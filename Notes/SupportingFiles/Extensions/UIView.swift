//
//  UIView.swift
//  Notes
//
//  Created by Dmitry on 21.12.2022.
//

import UIKit

extension UIView {
    
    func addView(_ view: UIView) {
          self.addSubview(view)
          view.translatesAutoresizingMaskIntoConstraints = false
    }
}
