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
    
    private let tokenValidity = 30 * 60 // 30 minutes
    private let dateFormatter = DateFormatter()
    
    private let settingsRepository: SettingsRepository
    
    private let isfake = false
    
    init(settingsRepository: SettingsRepository) {
        self.settingsRepository = settingsRepository
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func sendDiagnosisCode(code: String) -> Observable<Bool> {
        .create { [weak self] observer in
            
            let onset = Date(timeIntervalSinceNow: TimeInterval(Config.timeForKeys))
//            let udid: String = self?.settingsRepository.getSettings()?.udid ?? ""
            let udid = UUID().uuidString
            guard let token = self?.getToken(id: udid, reportCode: code, onset: onset) else {
                observer.onError("Couldn't Create Token")
                return Disposables.create()
            }
            
            DP3TTracing.iWasExposed(onset: onset,
                                    authentication: .HTTPAuthorizationBearer(token: token), isFakeRequest: self?.isfake ?? false) {  result in
                switch result {
                    case let .failure(error):
                        observer.onError(error)
                    default:
                        observer.onNext(true)
                        observer.onCompleted()
                }
            }
            return Disposables.create()
        }
            
    }
    
    private func getToken(id: String, reportCode: String, onset: Date) -> String? {

        let expirationDate = Date(timeIntervalSinceNow: TimeInterval(tokenValidity))
        
        let header = Header()
        var claims = MyClaims()
        claims.iss = "http://es.gob.radarcovid.android"
        claims.aud = ["http://es.gob.radarcovid.android"]
        claims.sub = "iosApp"
        claims.exp = expirationDate
        claims.iat = Date()
        claims.jti = id
        claims.scope = "exposed"
        claims.onSet = dateFormatter.string(from: onset)
        claims.tan = reportCode
        
        let privateKey: Data? = Config.privateKey.data(using: .utf8)!
        var myJWT = JWT(header: header, claims: claims)
        let jwtSigner = JWTSigner.rs256(privateKey: privateKey ?? Data())
        
        do {
            let signedJWT = try myJWT.sign(using: jwtSigner)
            return signedJWT.description
        } catch let error {
            os_log("Error signing token  %@", log: OSLog.default, type: .error,  error.localizedDescription)
        }
            
        return nil
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



