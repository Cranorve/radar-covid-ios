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
            self.tag = 555
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

class LocalizableLabel: UILabel {
    var _locKey:String?
    @IBInspectable var locKeyLocalizable: String? {
        get { return _locKey }
        set(key) {
            self._locKey = key
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
    
    func updateTexts(){
        let regularText = locKeyLocalizable?.localized ?? ""
        print(regularText)
        if locKeyLocalizable?.isAttributedText ?? false {
            attributedText = locKeyLocalizable?.localizedAttributed(withSize: self.font.pointSize)
        } else {
            let finalText = locKeyLocalizable?.localized
            text = finalText
        }
    }
}
