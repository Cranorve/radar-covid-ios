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
    case MyHealth
    case MyHealthReported
    case Exposition
    case HighExposition
    case Poll
    case Contact
}

class AppRouter : Router {
    
    var termsVC: TermsViewController?
    var homeVC: HomeViewController?
    var onBoardingVC: OnBoardingViewController?
    var tabBarController: TabBarController?
    var myHealthVC: MyHealthViewController?
    var myHealthReportedVC: MyHealthReportedViewController?
    var expositionVC: ExpositionViewController?
    var highExpositionVC: HighExpositionViewController?
    var contactVC: ContactViewController?
    var pollVC: PollViewController?
    
    func route(to routeID: Routes, from context: UIViewController, parameters: Any?...) {
        switch routeID {
        case .OnBoarding:
            routeToOnboarding(context)
        case .Home:
            routeToHome(context)
        case .Terms:
            routeToTerms(context)
        case .MyHealth:
            routeToMyHealth(context)
        case .MyHealthReported:
            routeToMyHealthReported(context)
        case .Exposition:
            routeToExposition(context)
        case .HighExposition:
            routeToHighExposition(context)
        case .Poll:
            routeToPoll(context)
        case.Contact:
            routeToContact(context)
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
    
    private func routeToMyHealth(_ context: UIViewController) {
        context.navigationController?.pushViewController(myHealthVC!, animated: true)
    }
    
    private func routeToMyHealthReported(_ context: UIViewController) {
        context.navigationController?.pushViewController(myHealthReportedVC!, animated: true)
    }
    
    private func routeToExposition(_ context: UIViewController) {
        context.navigationController?.pushViewController(expositionVC!, animated: true)
    }
    
    private func routeToHighExposition(_ context: UIViewController) {
        context.navigationController?.pushViewController(highExpositionVC!, animated: true)
    }
    
    private func routeToPoll(_ context: UIViewController) {
        context.navigationController?.pushViewController(pollVC!, animated: true)
    }
    
    private func routeToContact(_ context: UIViewController) {
        context.navigationController?.pushViewController(contactVC!, animated: true)
    }
    
    private func loadViewAsRoot(navController: UINavigationController?, view: UIViewController) {
        navController?.viewControllers.removeAll()
        navController?.popToRootViewController(animated: false)
        navController?.pushViewController(view, animated: false)
    }

}
