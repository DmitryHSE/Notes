//
//  UIViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

extension UIViewController {
    
    func emptyHeaderAlert() {
        let title = "You can't save new Note without header! Сontinue editing?"
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertYes = UIAlertAction(title: "Yes", style: .default)
        let alertNo = UIAlertAction(title: "No, quit", style: .cancel, handler: { action in
            self.dismiss(animated: true)
        })
        alertController.addAction(alertYes)
        alertController.addAction(alertNo)
        present(alertController, animated: true, completion: nil )
    }
}
