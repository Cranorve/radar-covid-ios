//
//  Config.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import DP3TSDK

struct Config {
    
    static let configUrl: String = "https://d3d0clxg4q92wk.cloudfront.net/configuration"
    static let pollUrl : String = "https://d3d0clxg4q92wk.cloudfront.net/questionnaire"
    static let dppptUrl : String = "https://d3d0clxg4q92wk.cloudfront.net/dp3t/v1/gaen"
    static let verificationUrl : String = "https://d3d0clxg4q92wk.cloudfront.net/verification"
    
    static let dp3tMode: ApplicationDescriptor.Mode = .test
    
    // Share keys of last 14 days
    static let timeForKeys = -60 * 60 * 24 * 14
}
