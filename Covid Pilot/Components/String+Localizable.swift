//
//  String+Localizable.swift
//  Covid Pilot
//
//  Created by alopezh on 09/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

extension String: Localizable {
    
    var localized: String {
        LocalizationHolder.localizationMap?[self] ?? NSLocalizedString(self, comment: "")
    }
    
    var isAttributedText: Bool {
        localized.contains("/>")
    }
    
    var localizedAttributed: NSMutableAttributedString {
//        TODO: parsear string y obtener las secciones negrita etc...
        NSMutableAttributedString()
    }
    
    
}
