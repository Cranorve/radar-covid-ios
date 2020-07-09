//
//  UIFont+Extension.swift
//  Covid Pilot
//
//  Created by Noel Carcases on 09/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    func defaultFont(withSize size: CGFloat, _ light: Bool = false, _ cursive: Bool = false, _ bold: Bool = false) -> UIFont {
        var fontName = "Muli-Regular"
        if light {
            fontName = "Muli-Light"
        }
        else if cursive {
            fontName = "Muli-Italic"
        }
        else if bold {
            fontName = "Muli-Bold"
        }
       
        return UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
