//
//  DiagnosisCodeUseCase.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 15/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift

class DiagnosisCodeUseCase {
    private let response: Bool
    
    init() {
        self.response = false
    }
    
    func sendDiagnosisCode() -> Observable<Bool> {
        .just(true)
    }
}
