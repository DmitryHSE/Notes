//
//  NoteViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    private var dataModel = DataModel(header: "", textBody: "")
    var passDataModelDelegate: PassDataModelProtocol?
    
    var myTextView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Avenir Next", size: 25)
        return textView
    }()
    
    var textBody: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 15
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Avenir Next", size: 20)
        return textView
    }()
    
    override func viewDidLoad() {
        title = "New note"
        super.viewDidLoad()
        textBody.delegate = self
        myTextView.delegate = self
        setupNavigationBar()
        setupViews()
        setConstraintes()
        notifications()
        setupSaveButton()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        view.addView(myTextView)
        view.addView(textBody)
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
            textBody.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -keyboardRectangle.height).isActive = true
           
        }
    }
    
    private func setConstraintes() {
        NSLayoutConstraint.activate([
            myTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            myTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            myTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            myTextView.heightAnchor.constraint(equalToConstant: 45),
            
            textBody.topAnchor.constraint(equalTo: myTextView.bottomAnchor, constant: 10),
            textBody.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textBody.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textBody.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension NoteViewController {
    private func setupSaveButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveAndDismiss(sender:)))
    }
    
    @objc func saveAndDismiss(sender: UIBarButtonItem) {
        passDataModelDelegate?.recieveDataModelFromEditScreen(datamodel: dataModel)
        self.dismiss(animated: true)
    }
}

extension NoteViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == myTextView {
            dataModel.header = textView.text
            //print("myTextView")
        }
        if textView == textBody {
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
