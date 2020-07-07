//
//  ErrorUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 06/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class ErrorUseCase {
    private let subject = BehaviorSubject<DomainError?>(value: nil)
    
    func errors() -> Observable<DomainError?> {
        subject.asObservable()
    }
    
    func setState(error: DomainError) {
        subject.onNext(error)
    }
}
