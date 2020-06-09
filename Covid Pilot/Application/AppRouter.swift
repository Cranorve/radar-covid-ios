//
//  AppRouter.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    func route(
        to routeID: Routes,
        from context: UIViewController,
        parameters: Any?...
    )
}

public enum Routes {
    case OnBoarding
    case Home
    case Terms
}

class AppRouter : Router {
    
    var termsVC: TermsViewController?
    var homeVC: HomeViewController?
    var onBoardingVC: OnBoardingViewController?
    var tabBarController: TabBarController?
    
    func route(to routeID: Routes, from context: UIViewController, parameters: Any?...) {
        switch routeID {
        case .OnBoarding:
            routeToOnboarding(context)
        case .Home:
            routeToHome(context)
        case .Terms:
            routeToTerms(context)
        }
    }
    
    private func routeToOnboarding(_ context: UIViewController) {
        loadViewAsRoot(navController: context as? UINavigationController, view: onBoardingVC!)
    }
    
    private func routeToHome(_ context: UIViewController) {
        loadViewAsRoot(navController: context.navigationController, view: tabBarController!)
    }
    
    private func routeToTerms(_ context: UIViewController) {
        loadViewAsRoot(navController: context.navigationController, view: termsVC!)
    }
    
    private func loadViewAsRoot(navController: UINavigationController?, view: UIViewController) {
        navController?.viewControllers.removeAll()
        navController?.popToRootViewController(animated: false)
        navController?.pushViewController(view, animated: false)
    }

}
