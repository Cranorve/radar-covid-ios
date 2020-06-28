//
//  UIColor+Extension.swift
//  Covid Pilot
//
//  Created by Noel Carcases on 28/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit
extension UIColor {
    @nonobjc static var app: UIColor {
        return UIColor(red: 0.37, green: 0.41, blue: 0.91, alpha: 1.0)
    }
    func fromHex(hex: String) -> UIColor{
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        guard let int = Scanner(string: hex).scanInt32(representation: .hexadecimal) else { return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) }

        let a, r, g, b: Int32
        switch hex.count {
           case 3:     (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)  // RGB (12-bit)
           case 6:     (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)                    // RGB (24-bit)
           case 8:     (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)       // ARGB (32-bit)
           default:    (a, r, g, b) = (255, 0, 0, 0)
        }

        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)

    }
}
