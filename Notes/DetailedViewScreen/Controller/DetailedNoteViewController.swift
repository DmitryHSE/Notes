//
//  DetailedNoteViewController.swift
//  Notes
//
//  Created by Dmitry on 22.12.2022.
//


import UIKit

class DetailedNoteViewController:BaseViewController<DetailedNoteView> {
    
    var dataModel = DataModel(header: "", textBody: "")
    var dataModelIndex: Int?
    private var editedDataModel = DataModel(header: "", textBody: "")
    var updateEditedNotedelegate: UpdateEditedNoteProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        notifications()
        setupSaveButton()
        setupBackButton()
        setupNoteViews()
    }
    
    private func setupViews() {
        editedDataModel = dataModel
        title = dataModel.header
        view.backgroundColor = .white
        mainView.textBodyView.delegate = self
        mainView.headerView.delegate = self
        

    }
    
    private func setupNoteViews() {
        if dataModel.header != "" {
            mainView.textBodyView.text = dataModel.textBody
            mainView.headerView.text = dataModel.header
            mainView.headerView.isEditable = false
            mainView.textBodyView.isEditable = false
//            mainView.textBodyView.textColor = .black
//            mainView.headerView.textColor = .black
        }
    }
    
    private func notifications() {
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

extension DetailedNoteViewController {
    private func setupSaveButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self,
                                                            action: #selector(editNote(sender:)))

    }
    
    @objc func editNote(sender: UIBarButtonItem) {

        mainView.headerView.isEditable = true
        mainView.textBodyView.isEditable = true
        
    }
    
    private func setupBackButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(saveAndDismiss(sender:)))
    }
    @objc func saveAndDismiss(sender: UIBarButtonItem) {
        print("pushed back")
        if editedDataModel.header == "" {
            self.emptyHeaderAtExistingNoteAlert()
        } else if editedDataModel.header != dataModel.header || editedDataModel.textBody != dataModel.textBody  {
            self.updateEditedNotedelegate?.recieveUpdatedNoteDataModel(datamodel: editedDataModel, index: dataModelIndex!)
            self.noteWasEditedAlert()
        } else {
            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

//MARK: - UITextViewDelegate

extension DetailedNoteViewController: UITextViewDelegate {
    
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
            editedDataModel.header = textView.text
            //print("myTextView")
        }
        if textView == mainView.textBodyView {
            editedDataModel.textBody = textView.text
            //print("textBody")
        }
    }
}

extension DetailedNoteViewController {
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .white
        //title = "Edit note"
        //navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }
}
