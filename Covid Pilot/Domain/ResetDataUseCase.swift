//
//  ResetDataUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 28/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import RxSwift
import DP3TSDK

class ResetDataUseCase {
    
    private let expositionInfoRepository: ExpositionInfoRepository
    private let setupUseCase: SetupUseCase
    
    init(setupUseCase: SetupUseCase, expositionInfoRepository: ExpositionInfoRepository) {
        self.setupUseCase = setupUseCase
        self.expositionInfoRepository = expositionInfoRepository
    }
    
    func reset() -> Observable<Void> {
        .deferred { [weak self] in
            do {
                try DP3TTracing.reset()
                try self?.setupUseCase.initializeSDK()
                self?.expositionInfoRepository.clearData()
            } catch {
                return .error(error)
            }
            
            return .just(())
        }

    }
    
}
