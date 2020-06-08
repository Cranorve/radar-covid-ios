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

    case Terms

}

class AppRouter : Router {
    
    var termsVC: TermsViewController?
    
    func route(to routeID: Routes, from context: UIViewController, parameters: Any?...) {
        switch routeID {
        case .Terms:
            routeToTerms(context)
        }
    }
    
    private func routeToTerms(_ context: UIViewController) {
        self.loadViewAsRoot(navController: context as! UINavigationController, view: self.termsVC!)
    }
    
    private func loadViewAsRoot(navController: UINavigationController, view: UIViewController) {
        navController.viewControllers.removeAll()
        navController.popToRootViewController(animated: false)
        navController.pushViewController(view, animated: false)
    }

}
