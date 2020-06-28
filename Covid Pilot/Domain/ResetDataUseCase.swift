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
    
    func reset() -> Observable<Void> {
        .deferred {
            do {
                try DP3TTracing.reset()
            } catch {
                return .error(error)
            }
    
            return .just(())
        }

    }
    
}
