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
        case .pro: return "https://radarcovid.covid19.gob.es/configuration"
        }
    }
    var poll: String {
        switch self {
        case .pre: return "https://d3d0clxg4q92wk.cloudfront.net/questionnaire"
        case .pro: return "https://radarcovid.covid19.gob.es/questionnaire"
        }
    }
    var kpi: String {
        switch self {
        case .pre: return "https://d3d0clxg4q92wk.cloudfront.net/kpi"
        case .pro: return "https://radarcovid.covid19.gob.es/kpi"
        }
    }
    var dpppt: String {
        switch self {
        case .pre: return "https://d3d0clxg4q92wk.cloudfront.net/dp3t"
        case .pro: return "https://radarcovid.covid19.gob.es/dp3t"
        }
    }
    
    var verification: String {
        switch self {
        case .pre: return "https://d3d0clxg4q92wk.cloudfront.net/verification"
        case .pro: return "https://radarcovid.covid19.gob.es/verification"
        }
    }
}

struct Config {
    
    #if DEBUG_PRE
        static let debug = true
        static let environment = "PRE"
        static let endpoints: Endpoits = .pre
        static let dp3tMode: ApplicationDescriptor.Mode = .test
        static let dp3tValidationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")!
        static let verificationKey =  Data(base64Encoded:"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CQUdCeXFHU000OUFnRUdCU3VCQkFBakE0R0dBQVFCbUlXU0ptdGVGNkh2VnI0M1V5SzliZStlNkpPQgpDRjlVaXpMeis4a3padkVEc25nMGl3VEF3UVB0QzdBMDlzQjVMM3EwSUl1N250Yzd4U1VqSUdTakZvd0JXL0xPCnFtMTBYQ1NkUWNZT3BMTi85dUI1emZKVUZOY3B6Ynk4dDAzSlg3TUZiYi9vQm1pcFNNNHptSm1UajR3Qm9XZ2sKRlF6ZEJHcnAwR2laUU9WVXRtUT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==")!
    #elseif DEBUG_PRO
        static let debug = true
        static let environment = "PRO"
        static let endpoints: Endpoits = .pro
        static let dp3tMode: ApplicationDescriptor.Mode = .test
        static let dp3tValidationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")!
        static let verificationKey =  Data(base64Encoded:"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CQUdCeXFHU000OUFnRUdCU3VCQkFBakE0R0dBQVFBWjM1ZzlhN1M2MjdXMVlpOEVsVmdNS012dkdUUAo5R0hiUHZHTzhLekNLQk84WTZOc0JSTHlJeWUwZmdxR0ZXM2Z5dHVxcnFSNi9wSllDUWFXN1IyUnY3OEF4OXJhCmlYbmRVSmVyVk9KSHJRaFgxbnMrTjZxaVUxT0I4a3dUaWVuaCtuZDVVbXZUN24vK3hod3djK1RYa1lnNDBxOVcKUTRiVjBMbHRWbGRUSUlTK1QxOD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg====")!
    #elseif RELEASE_PRE
        static let debug = false
        static let environment = "PRE"
        static let endpoints: Endpoits = .pre
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let dp3tValidationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")!
        static let verificationKey =  Data(base64Encoded:"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CQUdCeXFHU000OUFnRUdCU3VCQkFBakE0R0dBQVFCbUlXU0ptdGVGNkh2VnI0M1V5SzliZStlNkpPQgpDRjlVaXpMeis4a3padkVEc25nMGl3VEF3UVB0QzdBMDlzQjVMM3EwSUl1N250Yzd4U1VqSUdTakZvd0JXL0xPCnFtMTBYQ1NkUWNZT3BMTi85dUI1emZKVUZOY3B6Ynk4dDAzSlg3TUZiYi9vQm1pcFNNNHptSm1UajR3Qm9XZ2sKRlF6ZEJHcnAwR2laUU9WVXRtUT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==")!
    #elseif RELEASE_PRO
        static let debug = false
        static let environment = "PRO"
        static let endpoints: Endpoits = .pro
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let dp3tValidationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")!
        static let verificationKey =  Data(base64Encoded:"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlHYk1CQUdCeXFHU000OUFnRUdCU3VCQkFBakE0R0dBQVFBWjM1ZzlhN1M2MjdXMVlpOEVsVmdNS012dkdUUAo5R0hiUHZHTzhLekNLQk84WTZOc0JSTHlJeWUwZmdxR0ZXM2Z5dHVxcnFSNi9wSllDUWFXN1IyUnY3OEF4OXJhCmlYbmRVSmVyVk9KSHJRaFgxbnMrTjZxaVUxT0I4a3dUaWVuaCtuZDVVbXZUN24vK3hod3djK1RYa1lnNDBxOVcKUTRiVjBMbHRWbGRUSUlTK1QxOD0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg====")!
    #endif
    
}
