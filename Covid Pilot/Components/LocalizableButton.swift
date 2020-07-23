//
//  LocalizableButton.swift
//  Covid Pilot
//
//  Created by alopezh on 13/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

extension UIButton: XibLocalizable {
    
    @IBInspectable var locKey: String? {
        get { return nil }
        set(key) {
            if key?.isAttributedText ?? false {
                setAttributedTitle(key?.localizedAttributed, for: .normal)
            } else {
                setTitle(key?.localized, for: .normal)
            }
        }
    }
    


}

