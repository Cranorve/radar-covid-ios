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
}

struct Config {
    
    #if DEBUG_PRE
        static let debug = true
        static let environment = "PRE"
        static let endpoints: Endpoits = .pre
        static let dp3tMode: ApplicationDescriptor.Mode = .test
        static let validationKey = Data(base64Encoded:"LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")
        static let privateKey = privateKeyPre
    #elseif DEBUG_PRO
        static let debug = true
        static let environment = "PRO"
        static let endpoints: Endpoits = .pro
        static let dp3tMode: ApplicationDescriptor.Mode = .test
        static let validationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")
        static let privateKey = privateKeyPro
    #elseif RELEASE_PRE
        static let debug = false
        static let environment = "PRE"
        static let endpoints: Endpoits = .pre
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let validationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")
        static let privateKey = privateKeyPre
    #elseif RELEASE_PRO
        static let debug = false
        static let environment = "PRO"
        static let endpoints: Endpoits = .pro
        static let dp3tMode: ApplicationDescriptor.Mode = .production
        static let validationKey = Data(base64Encoded: "LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUZrd0V3WUhLb1pJemowQ0FRWUlLb1pJemowREFRY0RRZ0FFdmx1bzYyTFVVcFllcVVGM3haWVhYSG03cjBGWApScENFbVBqTUlxUHVERjcvYmRua1FIbndxbVNoVzIvOU9BcllEd09FUUZmdEE4ZDV6T3NEZmh0T2NRPT0KLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0t")
        static let privateKey = privateKeyPro
    #endif
    
    
    // Share keys of last 14 days
    static let timeForKeys = -60 * 60 * 24 * 14
    
    
    static let timeTable = "Horario lunes a viernes de 08H a 20H"
    static let contactNumber = "900 112 061"
    static let contactEmail = "piloto.appcovid@economia.gob.es"
    
    
    static private let privateKeyPro = """
-----BEGIN PRIVATE KEY-----
MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCqrR5XuoarZfjN
QBxDSf/fea4Fj/OmI7j2jECeqAP0mvobeBoc4byWiQNi+lPSQPHQjo9VLEjOevHA
S8zkMs29fPj3FMbG9YhebH1ag8RE9T5/evF4+FOnmr+V4huGt1NXLNyUYWXg8LFC
PnlFgJRfr+a4nWQurqk+kTmCUrI1OorfGscSo9IbGpNXUdOMkPYiXgbz1mGt7XCz
jnPnzjydJMxvO+pqcSK9OMQpmWic9LBq6Yk1aAuYXAkzCx6S5Uql7Ad2+QATbTKQ
+5Vs2rl66FbmKFjR2rGsZ0uAVF06wQToo/9BWsg0zCnoaywSvtz+5ucPR0Pp/Fef
Qg1tt+OzAgMBAAECggEARutokEuRaecVWzQoik1VZSbKiMUoGQD++nOM5mAqRJmh
E4j0UMv78RE9twMNkXArCt4x8NJV7nZnvd/BY5E4rGQhj4myjzm3UIUEEXhvNbgy
IAaWEA4ftKU4tq8dgPzsRGz/uyg9jRp2jXAoNBkZjikpVc0Qs9Ufvj/aBa0XH8Zl
9lHtiaEy8Ddl1uxfX8qGxxQaeL1K0IEgsksQ1zD5kVjW95GtKoRmxZyq8tXiBZ5s
QgYE22vzUC2+JQpCqRimxFNEarMqaTKroDaMYTd54FL8EKO8saNXIxm9UoAkJy8X
63JPYwNLxPQLK+77k90u2qRfmaqF8m7lOMEtZ6U+AQKBgQDSTWg+Ja+7oyPhtF6D
dit2xSag3vcm0wtlztWWTUqmcMKRpQMrG7o+jJPMPQF+EB8+o6CQspqa4UBTiw80
fUTkkxhOefjXQkpKNGYIPSHHVK0SWjUM6bAFNKUzhp0b29c0uD7M8/MgamuAAksn
hTxbmTs3Hn2BR6vp7rX6NIPymwKBgQDPw2jMDQDBLA8nbKGUj4juzcWsWnB+aQ9O
GFpgvbF0dZyC1UVWWy8O0AxLtTv4ISKWeYBB5ep7R8tBXLMK/jTbHzeDdgKrG3eL
Ot8ieMk8h5O+WIL2375LitonzdHQy1RQFwewcogBW604yjQaL2ueDVlQ5ioG8wod
TFAnS624yQKBgQCEzqN1E8GdolHnmEtTg83A7JIPZ5724rJA8dSKXXc2EuGcrnOI
xrLgC1DO2vvVS4MfwJ+GoXPnOTaxS5EnmbBnFMl1zasq7U8S+3Iv48MwKTY+776u
z+j78JofJvSSgkuunGf0cF5qaypGJaymYYqTYfo2PcgOW1+ilMBRKNbm3wKBgQC/
iqQfGw3LCdeevSPqVrojj0nisC5uHGWj1gfckIX9nECCziRyjPZBbcUoNxnmlIXS
vIlmN5WJupLE27WlON959Lm1VSL4pQX9MnVsznaYe1XWcruq5nQGKSke8T2yhQJi
JBlOrwh8WAzHAoQub/GDcUMatleguIhmomhzEe5DIQKBgA15uQHrfvwPLkEZ8W+2
rdWDOTmAW1xEUuU2g7mxQOe7wdtyt0NT3hmrKY74f30oK7woowSVHDlrpGnEbLcd
HsELNzHvQqVvfBOMm/cK7d3IgvLqneMNeSAuqV0nH+WtIwVQ1juCgBpR/1qyIPZV
23LS27VVQhvxBgjSxSLudBdP
-----END PRIVATE KEY-----
"""
    
    
    static private let privateKeyPre = """
-----BEGIN PRIVATE KEY-----
MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDJN9fFcfhD7JK6
x1rH4aFBDBxHiOUIxq6bu/FvNEhoNAdLN/ArTnTN3lgX9iJy1g07+aFzWK4H8tub
FCFq4W63fxQCx0l4ZxtiHJLoSSOByIeOza8NU7mmnaKSbvX7wrVqJQYKCYpA3eLu
79xT9oRYy+GgTbNqYDnkL+QEnJ2t7SHHQbucMxBr3sggmuxeO0mRAbIZNhf/ozcu
6K4ZSMm8A34j4lcfHdM3WxklbVZP2CMUyrVVJCMYfX4YmtGgYF8TpbFqlqJVyodV
5gtR/Ead5QuJ/oZXLN5V/q6jYFQc2QVbNJukER1VKet4R7ijab5ayZhYEx/r9Nea
g2EwZdd9AgMBAAECggEAdZbfzrAS0McA3IxB/gtabCQCpr9WcXGCetozdrRMGDFH
jeqLvRMlaWWlf6NEcG2s4D663iiV02lWcuMpwEcrp6po7FLAGc/Pjd967qpHSMIC
ji6fPR+Pn9IBPqf/sngQAo7OX7FBjTTeOJoN3Td0ElxbZ43g6qp/Sl2+V/+amheu
nY7M178EKH7F04uVdN6FI8WmK/QEWmCex3AWsQyoIVlLz/scFV4tS42NzgbUWUq/
8I+Y9n7G0DR8FXBAcwtZFHpsmuc+ddc/FrDSrY67Hztl+Cq1szv7e+2Efr2VdKPY
f8HcRFyx3jIMqvJXS1uT8vvTNJ8FlXTyAFEmDUgx4QKBgQD6Jt4Qf1+glSyFwL9g
skRZ6Kbc/NWkilcCmlKSUJCT3Y2bcpbtVrpiT6nIu1QrVZLQgQEYjPFvXHhBvcFl
bfkePnr7PqxoRecLjhHz/jk96u2fPHUMCMm0cIWV59ayDnrb+VDHhU5oVO7zBFvI
9khs1MrxkVfy3IG/4n+Oo3a1yQKBgQDN7BzFySj+8epARgHCaaZ8CBTScJcgSJEe
cs/OXAgIUo5sHLYBqLd7/UU4g65uagffa0OYsM4P3siB561vMjX55Ng/W1qj2mPN
LohUUzlw3dzOFvLsMxB0ZJZdNgGBy+QWGCPnVEZg5Mx7FvvZja5+kJc8+1JAg9a+
ustpYLB+FQKBgEwn6RM8s/A/ef5+X8UggI6eta4xixk8xKCWOu0wedOKb8ITcL9w
1+12M0pZPZazxq6Tl7HRtu8gR7w7+NTYVi9O9kHnIrXcEisCZZTSoLqo+w6vaTLw
ufelCgZJPqOWpPCzRlR30RcSRGzXttnHoOUBI4fHp+7YEuhIHG1gdpOBAoGAcBGH
GzE+SXm5Jh+zh23eOHRheKHj7aLwr6SGaeV2Tak4b6g0ebSrnyQYjwhDXz3/aN1E
nY3jp4l0kBZZMkIeVBDyi5CZRMFvPVSMx2+/vChSqiqdLGUiGGZB2xqwOUaQrGGY
8KXR45vBmV/J0v2jsKfaV0rj2c6miYi5eXEwvH0CgYBXZmZMsKQpTYFfLqcQXiDm
TDDoagPRPZXLTwt+PafMvV2HaVzAT6Gyj4j0ZPiS9Ia9RPeYzr90Qa30IdMYLzBU
onT01NgjdZUSFPms6ymO+5utO4kjzXE59wmjfyEgDgNzXTfE7N+qCW9B0xyy2q6W
AhiEiRdPK8qM956BrjVmhQ==
-----END PRIVATE KEY-----
"""
    
}
