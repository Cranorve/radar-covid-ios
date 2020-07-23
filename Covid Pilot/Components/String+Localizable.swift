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
        localized.contains("</")
    }
    
    var localizedAttributed: NSMutableAttributedString {
        return localizedAttributed()
    }
    
    func localizedAttributed(withParams params:[String] ) -> NSMutableAttributedString{
        var string = self.localized
        if string.contains("%@") {
            string = String(format: string, arguments: params)
        }
        return string.localizedAttributed
        
    }
    
    func localizedAttributed(withSize size: CGFloat = 16) -> NSMutableAttributedString{
        let string = LocalizationHolder.localizationMap?[self] ?? NSLocalizedString(self, comment: "")
        return string.htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli", andSize: size, perserveFont: true) ?? NSMutableAttributedString(string: string)
        
    }
    
    
}
