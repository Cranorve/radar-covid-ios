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
    
    func route(to routeID: Routes, from context: UIViewController, parameters: Any?...) {
        switch routeID {
        case .Terms:
            routeToTerms(context)
        }
    }
    
    private func routeToTerms(_ context: UIViewController) {
        //Instantiate the view controller
        let viewController: TermsViewController =
            UIStoryboard(name: "Terms", bundle: Bundle.main)
                .instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController

        self.loadViewAsRoot(navController: context as! UINavigationController, view: viewController)
    }
    
    private func loadViewAsRoot(navController: UINavigationController, view: UIViewController) {
        navController.viewControllers.removeAll()
        navController.popToRootViewController(animated: false)
        navController.pushViewController(view, animated: false)
    }

}
