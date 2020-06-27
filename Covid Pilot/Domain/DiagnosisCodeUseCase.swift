//
//  DiagnosisCodeUseCase.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 15/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift
import DP3TSDK
import SwiftJWT

class DiagnosisCodeUseCase {
    
    
    
    private let isfake = false
    
    private let response: Bool
    
    init() {
        self.response = false
    }
    
    func sendDiagnosisCode(code: String) -> Observable<Bool> {
        .create { [weak self] observer in
            let onset = Date(timeIntervalSinceNow: TimeInterval(Config.timeForKeys))
            let token = self?.getToken(reportCode: code, onset: onset)
            DP3TTracing.iWasExposed(onset: onset,
                                    authentication: .none, isFakeRequest: self?.isfake ?? false) {  result in
                switch result {
                    case let .failure(error):
//                        TODO: tratar los distintos casos de error
                        observer.onError(error)
                    default:
                        observer.onNext(true)
                        observer.onCompleted()
                }
            }
            return Disposables.create()
        }
            
    }
    
    private func getToken(reportCode: String, onset: Date) -> String {

        
        let issuedDate = Date()
        let expirationDate = Date()  // todo: calcular fecha +30
        
        let header = Header()
        let claims = ClaimsStandardJWT()
        claims.iss = "http://es.gob.radarcovid.android"
        claims.aud = ["http://es.gob.radarcovid.android"]
        claims.sub = "iosApp"
        claims.exp = expirationDate
        
        let privateKey: Data? = Config.privateKey.data(using: .utf8)!
        var myJWT = JWT(header: header, claims: claims)
        
        let jwtSigner = JWTSigner.rs256(privateKey: privateKey ?? Data())
        
        do {
            let signedJWT = try myJWT.sign(using: jwtSigner)
            return signedJWT.description
        } catch let error {
            debugPrint(error)
        }
            
        
        return ""
    }
    
    
}

struct MyClaims : Claims {
    public var iss: String?
    public var sub: String?
    public var aud: [String]?
    public var exp: Date?
    public var nbf: Date?
    public var iat: Date?
    public var jti: String?
    public var tan: String?
    public var scope: String?
    public var onSet: String?
}



