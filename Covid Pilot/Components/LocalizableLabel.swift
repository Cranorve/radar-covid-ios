//
//  LocalizableLabel.swift
//  Covid Pilot
//
//  Created by alopezh on 08/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

extension UILabel : XibLocalizable {
    @IBInspectable var locKey: String? {
        get { return nil }
        set(key) {
            let regularText = key?.localized ?? ""
            print(regularText)
            if key?.isAttributedText ?? false {
                attributedText = key?.localizedAttributed(withSize: self.font.pointSize)
            } else {
                let finalText = key?.localized
                text = finalText
            }
        }
    }
}
