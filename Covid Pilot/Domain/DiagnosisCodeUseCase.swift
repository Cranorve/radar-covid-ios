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
    private let verificationApi: VerificationControllerAPI
    
    private let isfake = false
    
    init(settingsRepository: SettingsRepository,
         verificationApi: VerificationControllerAPI) {
        self.settingsRepository = settingsRepository
        self.verificationApi  = verificationApi
        dateFormatter.dateFormat = "yyyy-MM-dd"
    }
    
    func sendDiagnosisCode(code: String) -> Observable<Bool> {

        return verificationApi.verifyCode(body: Code( date: nil, code: code ) )
            .catchError { [weak self] error in throw self?.mapError(error) ?? error }
            .flatMap { [weak self] tokenResponse -> Observable<Bool> in
//                let parsed = try self?.parseToken(tokenResponse.token)
//                parsed?.claims.onset
                return self?.iWasExposed(onset: Date(), token: tokenResponse.token) ?? .empty()
            }
            
    }
    
    private func iWasExposed(onset: Date, token: String) -> Observable<Bool> {
        .create { [weak self] observer in
            DP3TTracing.iWasExposed(onset: onset,
                                    authentication: .HTTPAuthorizationBearer(token: token), isFakeRequest: self?.isfake ?? false) {  result in
                switch result {
                    case let .failure(error):
                        observer.onError(self?.mapError(error) ?? error)
                    default:
                        observer.onNext(true)
                        observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
    
    private func parseToken(_ signedJWT: String) throws -> JWT<MyClaims> {
        let jwtVerifier = JWTVerifier.rs256(publicKey: Config.validationKey)
        let jwtDecoder = JWTDecoder(jwtVerifier: jwtVerifier)
        return try jwtDecoder.decode(JWT<MyClaims>.self, fromString: signedJWT)
    }
    
    private func is404(_ error: Error) -> Bool {
        if let code = getErrorCode(error) {
            return code == 404
        }
        return false
    }

    private func isPermissionRejected(_ error: Error) -> Bool {
        if let error = error as? DP3TTracingError {
            if case .exposureNotificationError = error {
                return true
            }
        }
        return false
    }
    
    private func getErrorCode(_ error: Error) -> Int? {
        if let error = error as? ErrorResponse {
            if case .error(let code, _, _) = error {
                return code
            }
        }
        return nil
    }
    
    private func mapError(_ error: Error) -> DiagnosisError {
        if is404(error) {
            return .IdAlreadyUsed(error)
        }
        if isPermissionRejected(error) {
            return .ApiRejected(error)
        }
        return .UnknownError(error)
    }
    
}

struct MyClaims : Claims {
    public var iss: String?
    public var sub: String?
    public var aud: String?
    public var exp: Int
    public var iat: Int
    public var jti: String?
    public var tan: String?
    public var scope: String?
    public var onset: String?
}

enum DiagnosisError: Error {
    case IdAlreadyUsed(Error?)
    case ApiRejected(Error?)
    case UnknownError(Error?)
}



