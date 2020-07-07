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
        case CONFIG
        case KPI
    }
    
    private let container: Container;
    
    init() {
        
        container = Container();
        
        container.register(SwaggerClientAPI.self, name: Endpoint.POLL.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.endpoints.poll;
            return swaggerApi;
        }.inObjectScope(.container)
        
        container.register(SwaggerClientAPI.self, name: Endpoint.CONFIG.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.endpoints.config;
            return swaggerApi;
        }.inObjectScope(.container)
        
        container.register(SwaggerClientAPI.self, name: Endpoint.KPI.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.endpoints.kpi;
            return swaggerApi;
        }.inObjectScope(.container)
        
        container.register(QuestionnaireControllerAPI.self) { r in
            QuestionnaireControllerAPI(clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.POLL.rawValue)!)
        }.inObjectScope(.container)
        
        container.register(AnswersControllerAPI.self) { r in
            AnswersControllerAPI(clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.POLL.rawValue)!)
        }.inObjectScope(.container)
        
        container.register(KpiControllerAPI.self) { r in
            KpiControllerAPI(clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.KPI.rawValue)!)
        }.inObjectScope(.container)
        
        container.register(TokenAPI.self) { r in
            TokenAPI(clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.CONFIG.rawValue)!)
        }.inObjectScope(.container)
        
        container.register(SettingsAPI.self) { r in
            SettingsAPI(clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.CONFIG.rawValue)!)
        }.inObjectScope(.container)
        
        container.register(AppRouter.self) { r in
            AppRouter()
        }.inObjectScope(.container)
        .initCompleted {r, appRouter in
            appRouter.infoVC = r.resolve(InfoViewController.self)!
            appRouter.homeVC = r.resolve(HomeViewController.self)!
            appRouter.onBoardingVC = r.resolve(OnBoardingViewController.self)!
            appRouter.tabBarController = r.resolve(TabBarController.self)!
            appRouter.myHealthVC = r.resolve(MyHealthViewController.self)!
            appRouter.myHealthReportedVC = r.resolve(MyHealthReportedViewController.self)!
            appRouter.expositionVC = r.resolve(ExpositionViewController.self)!
            appRouter.highExpositionVC = r.resolve(HighExpositionViewController.self)!
            appRouter.pollVC = r.resolve(PollViewController.self)!
            appRouter.pollFinishedVC = r.resolve(FinishPollViewController.self)!
            appRouter.welcomeVC = r.resolve(WelcomeViewController.self)!
        }
        
        container.register(PreferencesRepository.self) { r in
            UserDefaultsPreferencesRepository()
        }.inObjectScope(.container)
        
        container.register(SettingsRepository.self) { r in
            UserDefaultsSettingsRepository()
        }.inObjectScope(.container)
        
        container.register(ExpositionInfoRepository.self) { r in
            UserDefaultsExpositionInfoRepository()
        }.inObjectScope(.container)
        
        container.register(BluetoothHandler.self) { r in
            CentralManagerBluetoothHandler()
        }.inObjectScope(.container)

        container.register(VersionHandler.self) { r in
            VersionHandler()
        }.inObjectScope(.container)

        container.register(NotificationHandler.self) { r in
            NotificationHandler()
        }.inObjectScope(.container)
        
        container.register(OnboardingCompletedUseCase.self) { r in
            OnboardingCompletedUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(ExpositionUseCase.self) { r in
            ExpositionUseCase(notificationHandler: r.resolve(NotificationHandler.self)!,
                              expositionInfoRepository: r.resolve(ExpositionInfoRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(RadarStatusUseCase.self) { r in
            RadarStatusUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(BluetoothUseCase.self) { r in
            BluetoothUseCase(bluetoothHandler: r.resolve(BluetoothHandler.self)!,
                             preferencesRepository: r.resolve(PreferencesRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(ResetDataUseCase.self) { r in
            ResetDataUseCase(setupUseCase: r.resolve(SetupUseCase.self)!,
                             expositionInfoRepository: r.resolve(ExpositionInfoRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(PollUseCase.self) { r in
            PollUseCase(questionsApi: r.resolve(QuestionnaireControllerAPI.self)!,
                        answersApi: r.resolve(AnswersControllerAPI.self)!,
                        settingsRepository: r.resolve(SettingsRepository.self)!,
                        preferencesRepository: r.resolve(PreferencesRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(DiagnosisCodeUseCase.self) { r in
            DiagnosisCodeUseCase(settingsRepository: r.resolve(SettingsRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(ConfigurationUseCase.self) { r in
            ConfigurationUseCase(settingsRepository: r.resolve(SettingsRepository.self)!,
                                 tokenApi: r.resolve(TokenAPI.self)!,
                                 settingsApi: r.resolve(SettingsAPI.self)!,
                                 versionHandler: r.resolve(VersionHandler.self)!,
                                 syncUseCase: r.resolve(SyncUseCase.self)!)
        }.inObjectScope(.container)
        
        container.register(SyncUseCase.self) { r in
            SyncUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(SetupUseCase.self) { r in
            SetupUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!,
                         kpiApi: r.resolve(KpiControllerAPI.self)!,
                         notificationHandler: r.resolve(NotificationHandler.self)!)
        }.inObjectScope(.container)
        
        container.register(TabBarController.self) { r in
            TabBarController(
                homeViewController: r.resolve(HomeViewController.self)!,
                myDataViewController: r.resolve(MyDataViewController.self)!,
                helpLineViewController: r.resolve(HelpLineViewController.self)!,
                finishPollViewController: r.resolve(FinishPollViewController.self)!,
                preferencesRepository: r.resolve(PreferencesRepository.self)!
            )
        }
        
        container.register(InfoViewController.self) { r in
            let termsVC = self.createViewController(storyboard: "Info", id: "TermsViewController") as! InfoViewController
            termsVC.proximityVC = r.resolve(ProximityViewController.self)!
            return termsVC
        }
        
        container.register(ProximityViewController.self) {  r in
            let proxVC = ProximityViewController()
            proxVC.bluetoothUseCase = r.resolve(BluetoothUseCase.self)!
            proxVC.router = r.resolve(AppRouter.self)!
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
            homeVC.resetDataUseCase = r.resolve(ResetDataUseCase.self)!
            homeVC.syncUseCase = r.resolve(SyncUseCase.self)!
            homeVC.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)!
            return homeVC
        }
        
        container.register(MyDataViewController.self) {  r in
            self.createViewController(storyboard: "MyData", id: "MyDataViewController") as! MyDataViewController
        }
        
        container.register(HelpLineViewController.self) {  r in
            let helpVC = self.createViewController(storyboard: "HelpLine", id: "HelpLineViewController") as! HelpLineViewController
            helpVC.pollUseCase = r.resolve(PollUseCase.self)!
            helpVC.router = r.resolve(AppRouter.self)!
            helpVC.preferencesRepository = r.resolve(PreferencesRepository.self)!
            return helpVC
        }
        
        container.register(PollViewController.self) {  r in
            let pollVC = self.createViewController(storyboard: "Poll", id: "PollViewController") as! PollViewController
            pollVC.pollUseCase = r.resolve(PollUseCase.self)!
            pollVC.finishPollVC = r.resolve(FinishPollViewController.self)!
            pollVC.router = r.resolve(AppRouter.self)!
            return pollVC
        }
        
        container.register(FinishPollViewController.self) {  r in
            let finishPollVC = FinishPollViewController()
            return finishPollVC
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
            onbVC.router = r.resolve(AppRouter.self)!
            return onbVC
        }
        
        container.register(WelcomeViewController.self) {  r in
            let welcomeVC = WelcomeViewController()
            welcomeVC.router = r.resolve(AppRouter.self)!
            welcomeVC.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)!
            return welcomeVC
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
