//
//  ExpositionInfo.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

struct ExpositionInfo: Codable, Equatable {
    
    var level: Level
    var lastCheck: Date?
    var since: Date?
    
    public init(level: Level) {
        self.level = level
    }
    
    enum Level: String, Codable {
         case Healthy
         case Exposed
         case Infected
    }
    
}


