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
    case Root
    case Welcome
    case OnBoarding
    case Home
    case Proximity
    case MyHealth
    case MyHealthReported
    case Exposition
    case HighExposition
    case PositiveExposed
    case ActivateCovid
    case ActivatePush

}

class AppRouter : Router {
    
    var proxymityVC: ProximityViewController?
    var onBoardingVC: OnBoardingViewController?
    var rootVC: RootViewController?
    var tabBarController: TabBarController?
    var myHealthVC: MyHealthViewController?
    var myHealthReportedVC: MyHealthReportedViewController?
    var expositionVC: ExpositionViewController?
    var highExpositionVC: HighExpositionViewController?
    var positiveExposedVC: PositiveExposedViewController?
    var welcomeVC: WelcomeViewController?
    var activateCovid: ActivateCovidNotificationViewController?
    var activatePush: ActivatePushNotificationViewController?

    func route(to routeID: Routes, from context: UIViewController, parameters: Any?...) {
        switch routeID {
        case .Root:
            routeToRoot(context)
        case .Welcome:
            routeToWelcome(context)
        case .OnBoarding:
            routeToOnboarding(context)
        case .Home:
            routeToHome(context)
        case .Proximity:
            routeToProximity(context)
        case .ActivateCovid:
            routeToCovid(context)
        case .ActivatePush:
            routeToPush(context)
        case .MyHealth:
            routeToMyHealth(context)
        case .MyHealthReported:
            routeToMyHealthReported(context)
        case .Exposition:
            routeToHighExposition(context, since: parameters[0] as? Date)
        case .HighExposition:
            routeToHighExposition(context, since: parameters[0] as? Date)
        case .PositiveExposed:
            routeToPositiveExposed(context, since: parameters[0] as? Date)
        }
    }
    
    private func routeToOnboarding(_ context: UIViewController) {
        context.navigationController?.pushViewController(onBoardingVC!, animated: true)
    }
    
    private func routeToRoot(_ context: UIViewController) {
        loadViewAsRoot(navController: context as? UINavigationController, view: rootVC!)
    }
    
    private func routeToHome(_ context: UIViewController) {
        loadViewAsRoot(navController: context.navigationController, view: tabBarController!)
    }
    
    private func routeToProximity(_ context: UIViewController) {
        context.navigationController?.pushViewController(proxymityVC!, animated: true)
    }
    
    private func routeToCovid(_ context: UIViewController) {
       context.navigationController?.pushViewController(activateCovid!, animated: true)
    }
    
    private func routeToPush(_ context: UIViewController) {
       context.navigationController?.pushViewController(activatePush!, animated: true)
    }
    
    private func routeToMyHealth(_ context: UIViewController) {
        context.navigationController?.pushViewController(myHealthVC!, animated: true)
    }
    
    private func routeToMyHealthReported(_ context: UIViewController) {
        context.navigationController?.pushViewController(myHealthReportedVC!, animated: true)
    }
    
    private func routeToExposition(_ context: UIViewController, lastCheck: Date?) {
        expositionVC?.lastCheck = lastCheck
        context.navigationController?.pushViewController(expositionVC!, animated: true)
    }
    
    private func routeToHighExposition(_ context: UIViewController, since: Date?) {
        highExpositionVC?.since = since
        context.navigationController?.pushViewController(highExpositionVC!, animated: true)
    }
    
    private func routeToPositiveExposed(_ context: UIViewController, since: Date?) {
        positiveExposedVC?.since = since
        context.navigationController?.pushViewController(positiveExposedVC!, animated: true)
    }
    
    private func routeToWelcome(_ context: UIViewController) {
        loadViewAsRoot(navController: context.navigationController, view: welcomeVC!)
    }
    
    private func loadViewAsRoot(navController: UINavigationController?, view: UIViewController, animated: Bool = false) {
        navController?.viewControllers.removeAll()
        navController?.popToRootViewController(animated: false)
        navController?.pushViewController(view, animated: animated)
    }

}
