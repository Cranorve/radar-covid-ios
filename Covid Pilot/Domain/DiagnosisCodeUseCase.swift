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

class DiagnosisCodeUseCase {
    
    private let isfake = false
    
    private let response: Bool
    
    init() {
        self.response = false
    }
    
    func sendDiagnosisCode(code: String) -> Observable<Bool> {
        .create { [weak self] observer in
            DP3TTracing.iWasExposed(onset: Date(timeIntervalSinceNow: TimeInterval(Config.timeForKeys)),  authentication: .none, isFakeRequest: self?.isfake ?? false) {  result in
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
}
