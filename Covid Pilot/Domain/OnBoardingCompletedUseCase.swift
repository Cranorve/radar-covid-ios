//
//  OnBoardingCompletedUseCase.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

class OnboardingCompletedUseCase {
    
    private let preferencesRepository: PreferencesRepository
    
    init(preferencesRepository: PreferencesRepository) {
        self.preferencesRepository = preferencesRepository
    }
    
    func isOnBoardingCompleted() -> Bool {
        self.preferencesRepository.isOnBoardingCompleted() 
    }
    
    func setOnboarding(completed: Bool) {
        self.preferencesRepository.setOnboarding(completed: completed)
    }
    
}
