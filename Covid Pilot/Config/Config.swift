//
//  Config.swift
//  Covid Pilot
//
//  Created by alopezh on 12/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import DP3TSDK

enum Endpoits {
    case pre
    case pro
    
    var config: String {
        switch self {
        case .pre: return "https://d3d0clxg4q92wk.cloudfront.net/configuration"
        case .pro: return "https://dqarr2dc0prei.cloudfront.net/configuration"
        }
    }
    var poll: String {
        switch self {
        case .pre: return "https://d3d0clxg4q92wk.cloudfront.net/questionnaire"
        case .pro: return "https://dqarr2dc0prei.cloudfront.net/questionnaire"
        }
    }
    var dpppt: String {
        switch self {
        case .pre: return "https://d3d0clxg4q92wk.cloudfront.net/dp3t"
        case .pro: return "https://dqarr2dc0prei.cloudfront.net/dp3t"
        }
    }
}

struct Config {
    
    #if DEBUG_PRE
        static let debug = true
        static let endpoints: Endpoits = .pre
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let privateKey = "sedia_rsa_private_key_pre"
        static let validationKey = Data(base64Encoded:"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFd3o4YllrUWpucjk1eU1vSFo2aUlscXVyWklvUwpmbCtXRXpubXBueGxLak1Sa0d5SnhjdSswWkRRSkhmVGx6RXNGMDZ3ZnlPaFNtYzBkcW16Z1hTbFp3PT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")
    #elseif DEBUG_PRO
        static let debug = true
        static let endpoints: Endpoits = .pro
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let privateKey = "sedia_rsa_private_key_pro"
        static let validationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFUEFMemYyNFZwMDRtYk9aRWNKbnhyR1NDc3BUTApKT1VNcURXV1ZCU1JjSWl3NDR3Mm1JaFFIbEtNaHlyc2pHeVFMY0dxQXB2cTR6SEp2eVRNYi80ZE1RPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==")
    #elseif RELEASE_PRE
        static let debug = true
        static let endpoints: Endpoits = .pre
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let privateKey = "sedia_rsa_private_key_pre"
        static let validationKey = Data(base64Encoded:"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFd3o4YllrUWpucjk1eU1vSFo2aUlscXVyWklvUwpmbCtXRXpubXBueGxLak1Sa0d5SnhjdSswWkRRSkhmVGx6RXNGMDZ3ZnlPaFNtYzBkcW16Z1hTbFp3PT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")
    #elseif RELEASE_PRO
        static let debug = true
        static let endpoints: Endpoits = .pro
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let privateKey = "sedia_rsa_private_key_pre"
        static let validationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFUEFMemYyNFZwMDRtYk9aRWNKbnhyR1NDc3BUTApKT1VNcURXV1ZCU1JjSWl3NDR3Mm1JaFFIbEtNaHlyc2pHeVFMY0dxQXB2cTR6SEp2eVRNYi80ZE1RPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==")
    #endif
    
    
    // Share keys of last 14 days
    static let timeForKeys = -60 * 60 * 24 * 14
    
    
    static let timeTable = "Horario lunes a viernes de 08H a 20H"
    static let contactNumber = "900 112 061"
    static let contactEmail = "piloto.appcovid@economia.gob.es"
}
