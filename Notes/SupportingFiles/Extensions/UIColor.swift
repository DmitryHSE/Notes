//
//  UIColor.swift
//  Notes
//
//  Created by Dmitry on 24.12.2022.
//

import UIKit

extension UIColor {
    
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        let length = hexSanitized.count
        
        var rgb: UInt64 = 0
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }
        
        switch length {
        case 6:
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        case 8:
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        default:
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

enum Colors {
    static let softBlue = UIColor(hex: "#dcf0f5") ?? .systemGray2
    static let softPink = UIColor(hex: "#f1dcf5") ?? .systemGray2
    static let lightYellow = UIColor(hex: "#f2fcc7") ?? .systemGray2
    static let lightGreen = UIColor(hex: "#d7f7b7") ?? .systemGray2
    static let lightBlue = UIColor(hex: "#edfffb") ?? .systemGray2 
    static let gray = UIColor(hex: "#f0f0f0") ?? .systemGray2
}

