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
    #if RELEASE
        //PRO
        static let configUrl: String = "https://dqarr2dc0prei.cloudfront.net/configuration"
        static let pollUrl : String = "https://dqarr2dc0prei.cloudfront.net/questionnaire"
        static let dppptUrl : String = "https://dqarr2dc0prei.cloudfront.net/dp3t"
        static let verificationUrl : String = "https://dqarr2dc0prei.cloudfront.net/verification"
    #else
        //PRE
        static let configUrl: String = "https://d3d0clxg4q92wk.cloudfront.net/configuration"
        static let pollUrl : String = "https://d3d0clxg4q92wk.cloudfront.net/questionnaire"
        static let dppptUrl : String = "https://d3d0clxg4q92wk.cloudfront.net/dp3t"
        static let verificationUrl : String = "https://d3d0clxg4q92wk.cloudfront.net/verification"
    #endif
    
    static let dp3tMode: ApplicationDescriptor.Mode = .production
    
    // Share keys of last 14 days
    static let timeForKeys = -60 * 60 * 24 * 14
    
    static let validationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFUEFMemYyNFZwMDRtYk9aRWNKbnhyR1NDc3BUTApKT1VNcURXV1ZCU1JjSWl3NDR3Mm1JaFFIbEtNaHlyc2pHeVFMY0dxQXB2cTR6SEp2eVRNYi80ZE1RPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==")
    
    static let timeTable = "Horario lunes a viernes de 08H a 20H"
    static let contactNumber = "900 112 061"
    static let contactEmail = "piloto.appcovid@economia.gob.es"
}
