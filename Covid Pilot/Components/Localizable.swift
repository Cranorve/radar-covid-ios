//
//  Localizable.swift
//  Covid Pilot
//
//  Created by alopezh on 08/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

protocol Localizable {
    var localized: String { get }
    var isAttributedText: Bool { get }
    var localizedAttributed: NSAttributedString { get }
}
