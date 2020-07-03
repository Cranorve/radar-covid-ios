//
//  VersionHandler.swift
//  Covid Pilot
//
//  Created by alopezh on 03/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation


class VersionHandler {
    
    func getCurrenVersion() -> Int32? {
        (Bundle.main.infoDictionary?["CFBundleVersion"] as? NSString)?.intValue
    }
    
}
