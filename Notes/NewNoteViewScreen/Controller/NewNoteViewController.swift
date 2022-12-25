//
//  NoteViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class NewNoteViewController:BaseViewController<NewNoteView> {
    
    var dataModel = DataModel(header: "", textBody: "")
    var passDataModelDelegate: PassDataModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        notifications()
        setupSaveButton()
        setupNoteViews()
    }
    
    private func setupViews() {
        title = "New note"
        view.backgroundColor = .white
        mainView.textBodyView.delegate = self
        mainView.headerView.delegate = self
    }
    
    private func setupNoteViews() {
        mainView.textBodyView.backgroundColor = Colors.softBlue
        mainView.headerView.backgroundColor = Colors.softBlue
        if dataModel.header != "" {
            mainView.textBodyView.text = dataModel.textBody
            mainView.headerView.text = dataModel.header
            mainView.textBodyView.textColor = .black
            mainView.headerView.textColor = .black
        }
    }
    
    private func notifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handle(keyboardShowNotification:)),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
    }
    
    @objc private func handle(keyboardShowNotification notification: Notification) {
        if let userInfo = notification.userInfo,
            let keyboardRectangle = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            
            mainView.textBodyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardRectangle.height - 10).isActive = true
           
        }
    }
}

extension NewNoteViewController {
    private func setupSaveButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .save,
                                     target: self,
                                     action: #selector(saveAndDismiss(sender:)))
        button.tintColor = .black
        navigationItem.rightBarButtonItem = button

    }
    
    @objc func saveAndDismiss(sender: UIBarButtonItem) {

            if dataModel.header == "" {
                self.emptyHeaderAlert()
            } else {
                passDataModelDelegate?.recieveDataModelFromEditScreen(datamodel: dataModel)
                self.dismiss(animated: true)
            }
        
    }
}

//MARK: - UITextViewDelegate

extension NewNoteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .darkGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Type some here..."
            textView.textColor = .darkGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == mainView.headerView {
            dataModel.header = textView.text
        }
        if textView == mainView.textBodyView {
            dataModel.textBody = textView.text
        }
    }
}

// MARK: - Setup navigation bar

extension NewNoteViewController {
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = Colors.gray
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Bradley Hand", size: 28)!]
        title = "Edit note"
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
