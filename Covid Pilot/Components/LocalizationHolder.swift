//
//  LocalizationHolder.swift
//  Covid Pilot
//
//  Created by alopezh on 09/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

class LocalizationHolder {
    
    private static var _localizationMap: [String:String]?
    
    static var localizationMap: [String:String]? {
        get {
            if let localizationMap = _localizationMap {
                return localizationMap
            }
            if let source = source {
                _localizationMap = source.localizationMap
            }
            return _localizationMap
        }
        set (newLocalizationMap) {
            _localizationMap  = newLocalizationMap
        }

    }
    
    static var source: LocalizationSource?
}
