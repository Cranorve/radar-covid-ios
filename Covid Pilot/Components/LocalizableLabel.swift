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
            if key?.isAttributedText ?? false {
                text = locKey?.localized
            } else {
                attributedText = key?.localizedAttributed
            }
        }
    }
}
