//
//  String.swift
//  Notes
//
//  Created by Dmitry on 01.03.2023.
//

import UIKit

extension String {
    func getInitials(name: String) -> String {
        return name.components(separatedBy: " ").reduce("") { ($0 == "" ? "" : "\($0.first!)") + "\($1.first!)" }
    }
}
