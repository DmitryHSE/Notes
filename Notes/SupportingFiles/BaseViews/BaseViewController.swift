//
//  BaseViewController.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    var mainView: View { view as! View }
    
    override func loadView() {
            view = View()
    }
}
