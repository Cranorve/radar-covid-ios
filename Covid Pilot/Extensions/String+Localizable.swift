//
//  String+Localizable.swift
//  Covid Pilot
//
//  Created by alopezh on 09/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

extension String: Localizable {
    
    var localized: String {
        LocalizationHolder.localizationMap?[self] ?? NSLocalizedString(self, comment: "")
    }
    
    var isAttributedText: Bool {
        localized.contains("</") || localized.contains("<br")
    }
    
    var localizedAttributed: NSAttributedString {
        return localizedAttributed()
    }
    
    func localizedAttributed(withParams params:[String],  attributes: [NSAttributedString.Key : Any] = [:]) -> NSAttributedString {
        var string = self.localized
        if string.contains("%@") {
            string = String(format: string, arguments: params)
        }
        return string.localizedAttributed
        
    }
    
    func localizedAttributed(attributes: [NSAttributedString.Key : Any] = [:]) -> NSAttributedString {
        
        let string = LocalizationHolder.localizationMap?[self] ?? NSLocalizedString(self, comment: "")
    
        let attributed = string.htmlToAttributedString?.formatHtmlString(withBaseFont: attributes[NSAttributedString.Key.font] as? UIFont, perserveFont: false) ?? NSMutableAttributedString(string: string)
        if let color = attributes[NSAttributedString.Key.foregroundColor] {
            attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: color , range: NSRange(location: 0, length: attributed.length))
        }

        
        return attributed
        
    }
    
    
}
