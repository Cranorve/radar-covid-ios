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
    case Welcome
    case OnBoarding
    case Home
    case Info
    case MyHealth
    case MyHealthReported
    case Exposition
    case HighExposition
    case PositiveExposed
    case Poll
    case PollFinished
}

class AppRouter : Router {
    
    var infoVC: InfoViewController?
    var homeVC: HomeViewController?
    var onBoardingVC: OnBoardingViewController?
    var tabBarController: TabBarController?
    var myHealthVC: MyHealthViewController?
    var myHealthReportedVC: MyHealthReportedViewController?
    var expositionVC: ExpositionViewController?
    var highExpositionVC: HighExpositionViewController?
    var positiveExposedVC: PositiveExposedViewController?
    var pollVC: PollViewController?
    var pollFinishedVC: FinishPollViewController?
    var welcomeVC: WelcomeViewController?
    
    func route(to routeID: Routes, from context: UIViewController, parameters: Any?...) {
        switch routeID {
        case .Welcome:
            routeToWelcome(context)
        case .OnBoarding:
            routeToOnboarding(context)
        case .Home:
            routeToHome(context)
        case .Info:
            routeToInfo(context)
        case .MyHealth:
            routeToMyHealth(context)
        case .MyHealthReported:
            routeToMyHealthReported(context)
        case .Exposition:
            routeToExposition(context, lastCheck: parameters[0] as? Date)
        case .HighExposition:
            routeToHighExposition(context, since: parameters[0] as? Date)
        case .PositiveExposed:
            routeToPositiveExposed(context, since: parameters[0] as? Date)
        case .Poll:
            routeToPoll(context)
        case .PollFinished:
            routeToPollFinished(context)
        }
    }
    
    private func routeToOnboarding(_ context: UIViewController) {
        context.navigationController?.pushViewController(onBoardingVC!, animated: true)
    }
    
    private func routeToHome(_ context: UIViewController) {
        loadViewAsRoot(navController: context.navigationController, view: tabBarController!)
    }
    
    private func routeToInfo(_ context: UIViewController) {
        context.navigationController?.pushViewController(infoVC!, animated: true)
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
    
    private func routeToPoll(_ context: UIViewController) {
        context.navigationController?.pushViewController(pollVC!, animated: true)
    }
    
    private func routeToPollFinished(_ context: UIViewController) {
        context.navigationController?.pushViewController(pollFinishedVC!, animated: true)
    }
    
    private func routeToWelcome(_ context: UIViewController) {
        loadViewAsRoot(navController: context as? UINavigationController, view: welcomeVC!)
    }
    
    private func loadViewAsRoot(navController: UINavigationController?, view: UIViewController) {
        navController?.viewControllers.removeAll()
        navController?.popToRootViewController(animated: false)
        navController?.pushViewController(view, animated: false)
    }

}
