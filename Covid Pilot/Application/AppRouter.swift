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
    case Home
    case Terms

}

class AppRouter : Router {
    
    var termsVC: TermsViewController?
    var homeVC: HomeViewController?
    
    func route(to routeID: Routes, from context: UIViewController, parameters: Any?...) {
        switch routeID {
        case .Home:
            routeToHome(context)
        case .Terms:
            routeToTerms(context)
        }
    }
    
    private func routeToHome(_ context: UIViewController) {
        loadViewAsRoot(navController: context.navigationController, view: homeVC!)
    }
    
    private func routeToTerms(_ context: UIViewController) {
        loadViewAsRoot(navController: context as? UINavigationController, view: termsVC!)
    }
    
    private func loadViewAsRoot(navController: UINavigationController?, view: UIViewController) {
        navController?.viewControllers.removeAll()
        navController?.popToRootViewController(animated: false)
        navController?.pushViewController(view, animated: false)
    }

}
