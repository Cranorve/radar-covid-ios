//
//  Injection.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import Swinject
import UIKit

class Injection {
    
    private let container: Container;
    
    init() {
        
        container = Container();
        
        container.register(AppRouter.self) { r in
            AppRouter()
        }.inObjectScope(.container)
        .initCompleted {r, appRouter in
            appRouter.termsVC = r.resolve(TermsViewController.self)!
            appRouter.homeVC = r.resolve(HomeViewController.self)!
        }
        
        container.register(OnboardingCompletedUseCase.self) { r in
            OnboardingCompletedUseCase()
        }.inObjectScope(.container)
        
        container.register(TermsViewController.self) { r in
            let termsVC = self.createViewController(storyboard: "Terms", id: "TermsViewController") as! TermsViewController
            termsVC.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)
            termsVC.recomendationsVC = r.resolve(RecomendationsViewController.self)!
            return termsVC
        }
        
        container.register(RecomendationsViewController.self) {  r in
            let recVC = RecomendationsViewController()
            recVC.router = r.resolve(AppRouter.self)!
            return recVC
        }
        container.register(HomeViewController.self) {  r in
            self.createViewController(storyboard: "Home", id: "HomeViewController") as! HomeViewController
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
    
    private func createViewController(storyboard: String, id: String) -> UIViewController {
        UIStoryboard(name: storyboard, bundle: Bundle.main)
        .instantiateViewController(withIdentifier: id)
    }
}
