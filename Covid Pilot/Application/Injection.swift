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
    
    enum Endpoint: String {
        case POLL
    }
    
    private let container: Container;
    
    init() {
        
        container = Container();
        
        container.register(SwaggerClientAPI.self, name: Endpoint.POLL.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.pollUrl;
            return swaggerApi;
        }.inObjectScope(.container)
        
        container.register(QuestionnaireControllerAPI.self) { r in
            QuestionnaireControllerAPI(clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.POLL.rawValue)!)
        }.inObjectScope(.container)
        
        container.register(AnswersControllerAPI.self) { r in
            AnswersControllerAPI(clientApi: r.resolve(SwaggerClientAPI.self)!)
        }.inObjectScope(.container)
        
        container.register(AppRouter.self) { r in
            AppRouter()
        }.inObjectScope(.container)
        .initCompleted {r, appRouter in
            appRouter.termsVC = r.resolve(TermsViewController.self)!
            appRouter.homeVC = r.resolve(HomeViewController.self)!
            appRouter.onBoardingVC = r.resolve(OnBoardingViewController.self)!
            appRouter.tabBarController = r.resolve(TabBarController.self)!
            appRouter.myHealthVC = r.resolve(MyHealthViewController.self)!
            appRouter.myHealthReportedVC = r.resolve(MyHealthReportedViewController.self)!
            appRouter.expositionVC = r.resolve(ExpositionViewController.self)!
            appRouter.highExpositionVC = r.resolve(HighExpositionViewController.self)!
            appRouter.pollVC = r.resolve(PollViewController.self)!
            appRouter.contactVC = r.resolve(ContactViewController.self)!
        }
        
        container.register(PreferencesRepository.self) { r in
            UserDefaultsPreferencesRepository()
        }.inObjectScope(.container)
        
        container.register(BluetoothHandler.self) { r in
            CentralManagerBluetoothHandler()
        }.inObjectScope(.container)
        
        container.register(OnboardingCompletedUseCase.self) { r in
            OnboardingCompletedUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(ExpositionUseCase.self) { r in
            ExpositionUseCase()
        }.inObjectScope(.container)
        
        container.register(RadarStatusUseCase.self) { r in
            RadarStatusUseCase()
        }.inObjectScope(.container)
        
        container.register(BluetoothUseCase.self) { r in
            BluetoothUseCase(bluetoothHandler: r.resolve(BluetoothHandler.self)!)
        }.inObjectScope(.container)
        
        container.register(PollUseCase.self) { r in
            PollUseCase(questionsApi: r.resolve(QuestionnaireControllerAPI.self)!)
        }.inObjectScope(.container)
        
        container.register(DiagnosisCodeUseCase.self) { r in
            DiagnosisCodeUseCase()
        }
        
        container.register(TabBarController.self) { r in
            TabBarController(
                homeViewController: r.resolve(HomeViewController.self)!,
                myDataViewController: r.resolve(MyDataViewController.self)!,
                helpLineViewController: r.resolve(HelpLineViewController.self)!
            )
        }
        
        container.register(TermsViewController.self) { r in
            let termsVC = self.createViewController(storyboard: "Terms", id: "TermsViewController") as! TermsViewController
            termsVC.proximityVC = r.resolve(ProximityViewController.self)!
            return termsVC
        }
    
        
        container.register(ProximityViewController.self) {  r in
            let proxVC = ProximityViewController()
            proxVC.bluetoothUseCase = r.resolve(BluetoothUseCase.self)!
            proxVC.router = r.resolve(AppRouter.self)!
            proxVC.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)!
            return proxVC
        }
        
        container.register(ExpositionViewController.self) {  r in
            self.createViewController(storyboard: "Exposition", id: "ExpositionViewController") as! ExpositionViewController
        }
        
        container.register(HighExpositionViewController.self) {  r in
            self.createViewController(storyboard: "HighExposition", id: "HighExpositionViewController") as! HighExpositionViewController
        }
        
        container.register(HomeViewController.self) {  r in
            let homeVC = self.createViewController(storyboard: "Home", id: "HomeViewController") as! HomeViewController
            homeVC.router = r.resolve(AppRouter.self)!
            homeVC.expositionUseCase = r.resolve(ExpositionUseCase.self)!
            homeVC.radarStatusUseCase = r.resolve(RadarStatusUseCase.self)!
            return homeVC
        }
        
        container.register(MyDataViewController.self) {  r in
            self.createViewController(storyboard: "MyData", id: "MyDataViewController") as! MyDataViewController
        }
        
        container.register(HelpLineViewController.self) {  r in
            let helpVC = self.createViewController(storyboard: "HelpLine", id: "HelpLineViewController") as! HelpLineViewController
            helpVC.router = r.resolve(AppRouter.self)!
            return helpVC
        }
        
        container.register(ContactViewController.self) {  r in
            self.createViewController(storyboard: "Contact", id: "ContactViewController") as! ContactViewController
        }
        
        container.register(PollViewController.self) {  r in
            let pollVC = self.createViewController(storyboard: "Poll", id: "PollViewController") as! PollViewController
            pollVC.pollUseCase = r.resolve(PollUseCase.self)!
            return pollVC
        }
        
        container.register(MyHealthViewController.self) {  r in
            let myHealthVC = self.createViewController(storyboard: "MyHealth", id: "MyHealthViewController") as! MyHealthViewController
            myHealthVC.diagnosisCodeUseCase = r.resolve(DiagnosisCodeUseCase.self)!
            myHealthVC.router = r.resolve(AppRouter.self)!
            return myHealthVC
        }
        
        
        
        container.register(MyHealthReportedViewController.self) { r in
            let myHealthReportedVC = self.createViewController(storyboard: "MyHealthReported", id: "MyHealthReportedViewController") as! MyHealthReportedViewController
            myHealthReportedVC.router = r.resolve(AppRouter.self)!
            return myHealthReportedVC
        }
        
        container.register(OnBoardingViewController.self) {  r in
            let onbVC = self.createViewController(storyboard: "OnBoarding", id: "OnBoardingViewController") as! OnBoardingViewController
            
            onbVC.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)!
            onbVC.router = r.resolve(AppRouter.self)!
            return onbVC
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
