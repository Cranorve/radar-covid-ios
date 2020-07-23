//
//  LocalizationSource.swift
//  Covid Pilot
//
//  Created by alopezh on 09/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol LocalizationSource {
    var localizationMap: [String:String]? { get }
}
