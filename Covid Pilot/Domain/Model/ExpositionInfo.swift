//
//  ExpositionInfo.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

struct ExpositionInfo {
    
    var level: Level?
    
    public init(level: Level?) {
        self.level = level
    }

    enum Level {
         case Healthy(lastCheck: Date?)
         case Exposed(since: Date?)
         case Infected
    }
    
}


