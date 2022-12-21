//
//  NoteViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class NoteViewController:BaseViewController<NoteView> {
    
    private var dataModel = DataModel(header: "", textBody: "")
    var passDataModelDelegate: PassDataModelProtocol?
    
    override func viewDidLoad() {
        title = "New note"
        super.viewDidLoad()
        mainView.textBodyView.delegate = self
        mainView.headerView.delegate = self
        setupNavigationBar()
        setupViews()
        notifications()
        setupSaveButton()
    }
    
    private func setupViews() {
        view.backgroundColor = .white

    }
    
    func notifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(keyboardShowNotification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
    }
    
    @objc private func handle(keyboardShowNotification notification: Notification) {
        // 1
        print("Keyboard show notification")
        
        // 2
        if let userInfo = notification.userInfo,
            // 3
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            print(keyboardRectangle.height)
            mainView.textBodyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardRectangle.height).isActive = true
           
        }
    }
}

extension NoteViewController {
    private func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAndDismiss(sender:)))
    }
    
    @objc func saveAndDismiss(sender: UIBarButtonItem) {
        if dataModel.header != "" {
            passDataModelDelegate?.recieveDataModelFromEditScreen(datamodel: dataModel)
        }
        self.dismiss(animated: true)
    }
}

extension NoteViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == mainView.headerView {
            dataModel.header = textView.text
            //print("myTextView")
        }
        if textView == mainView.textBodyView {
            dataModel.textBody = textView.text
            //print("textBody")
        }
    }
}

extension NoteViewController {
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .white
        title = "Edit note"
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
