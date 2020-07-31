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
        case VERIFICATION
    }
    
    private let container: Container;
    
    init() {
        
        container = Container();
        
        container.register(SwaggerClientAPI.self, name: Endpoint.POLL.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.endpoints.poll
            return swaggerApi
        }.inObjectScope(.container)
        
        container.register(SwaggerClientAPI.self, name: Endpoint.CONFIG.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.endpoints.config
            return swaggerApi
        }.inObjectScope(.container)
        
        container.register(SwaggerClientAPI.self, name: Endpoint.KPI.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.endpoints.kpi
            return swaggerApi
        }.inObjectScope(.container)
        
        container.register(SwaggerClientAPI.self, name: Endpoint.VERIFICATION.rawValue) { r in
            let swaggerApi = SwaggerClientAPI()
            swaggerApi.basePath = Config.endpoints.verification
            return swaggerApi
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
            SettingsAPI(
                clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.CONFIG.rawValue)!
            )
        }.inObjectScope(.container)
        
        container.register(TextsAPI.self) { r in
            TextsAPI(
                clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.CONFIG.rawValue)!
            )
        }.inObjectScope(.container)
        
        container.register(MasterDataAPI.self) { r in
            MasterDataAPI(
                clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.CONFIG.rawValue)!
            )
        }.inObjectScope(.container)
        
        container.register(VerificationControllerAPI.self) { r in
            VerificationControllerAPI(
                clientApi: r.resolve(SwaggerClientAPI.self, name: Endpoint.VERIFICATION.rawValue)!
            )
        }.inObjectScope(.container)
        
        container.register(PreferencesRepository.self) { r in
            UserDefaultsPreferencesRepository()
        }.inObjectScope(.container)
        
        container.register(SettingsRepository.self) { r in
            UserDefaultsSettingsRepository()
        }.inObjectScope(.container)
        
        container.register(ExpositionInfoRepository.self) { r in
            UserDefaultsExpositionInfoRepository()
        }.inObjectScope(.container)
        
        container.register(LocalizationRepository.self) { r in
            UserDefaultsLocalizationRepository()
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
                              expositionInfoRepository: r.resolve(ExpositionInfoRepository.self)!,
                              errorUseCase: r.resolve(ErrorUseCase.self)!,
                              kpiControllerApi: r.resolve(KpiControllerAPI.self)!)
        }.inObjectScope(.container)
        
        container.register(RadarStatusUseCase.self) { r in
            RadarStatusUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!,
                               errorUseCase: r.resolve(ErrorUseCase.self)!,
                               syncUseCase: r.resolve(SyncUseCase.self)!)
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
                                 versionHandler: r.resolve(VersionHandler.self)!)
        }.inObjectScope(.container)
        
        container.register(SyncUseCase.self) { r in
            SyncUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(ErrorUseCase.self) { r in
            ErrorUseCase()
        }.inObjectScope(.container)
        
        container.register(SetupUseCase.self) { r in
            SetupUseCase(preferencesRepository: r.resolve(PreferencesRepository.self)!,
                         kpiApi: r.resolve(KpiControllerAPI.self)!,
                         errorUseCase: r.resolve(ErrorUseCase.self)!,
                         notificationHandler: r.resolve(NotificationHandler.self)!)
        }.inObjectScope(.container)
        
        container.register(LocalizationUseCase.self) { r in
            LocalizationUseCase(textsApi: r.resolve(TextsAPI.self)!,
                                localizationRepository: r.resolve(LocalizationRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(CCAAUseCase.self) { r in
            CCAAUseCase(masterDataApi: r.resolve(MasterDataAPI.self)!,
                        localizationRepository: r.resolve(LocalizationRepository.self)!)
        }.inObjectScope(.container)
        
        container.register(LocalesUseCase.self) { r in
            LocalesUseCase(localizationRepository: r.resolve(LocalizationRepository.self)!,
                           masterDataApi: r.resolve(MasterDataAPI.self)!)
        }.inObjectScope(.container)
        
        container.register(TabBarController.self) { r in
            TabBarController(
                homeViewController: r.resolve(HomeViewController.self)!,
                myDataViewController: r.resolve(MyDataViewController.self)!,
                helpLineViewController: r.resolve(HelpLineViewController.self)!,
                preferencesRepository: r.resolve(PreferencesRepository.self)!
            )
        }
        
        container.register(AppRouter.self) { r in
            AppRouter()
        }.initCompleted {r, appRouter in
            appRouter.rootVC = r.resolve(RootViewController.self)!
            appRouter.proxymityVC  = r.resolve(ProximityViewController.self)!
            appRouter.onBoardingVC = r.resolve(OnBoardingViewController.self)!
            appRouter.tabBarController = r.resolve(TabBarController.self)!
            appRouter.myHealthVC = r.resolve(MyHealthViewController.self)!
            appRouter.myHealthReportedVC = r.resolve(MyHealthReportedViewController.self)!
            appRouter.expositionVC = r.resolve(ExpositionViewController.self)!
            appRouter.highExpositionVC = r.resolve(HighExpositionViewController.self)!
            appRouter.positiveExposedVC = r.resolve(PositiveExposedViewController.self)!
            appRouter.welcomeVC = r.resolve(WelcomeViewController.self)!
            appRouter.activateCovid = r.resolve(ActivateCovidNotificationViewController.self)!
            appRouter.activatePush = r.resolve(ActivatePushNotificationViewController.self)!
        }
        
        
        container.register(ProximityViewController.self) {  r in
            let proxVC = ProximityViewController()
            proxVC.radarStatusUseCase = r.resolve(RadarStatusUseCase.self)!
            proxVC.router = r.resolve(AppRouter.self)!
            return proxVC
        }
        
        container.register(ExpositionViewController.self) {  r in
            self.createViewController(storyboard: "Exposition", id: "ExpositionViewController") as! ExpositionViewController
        }
        
        
        
        container.register(HighExpositionViewController.self) {  r in
            let highExposition = self.createViewController(storyboard: "HighExposition", id: "HighExpositionViewController") as! HighExpositionViewController
            highExposition.ccaUseCase = r.resolve(CCAAUseCase.self)!
            return highExposition
        }
        
        container.register(PositiveExposedViewController.self) {  r in
            self.createViewController(storyboard: "PositiveExposed", id: "PositiveExposedViewController") as! PositiveExposedViewController
            
        }
        
        container.register(HomeViewController.self) {  r in
            let homeVC = self.createViewController(storyboard: "Home", id: "HomeViewController") as! HomeViewController
            homeVC.router = r.resolve(AppRouter.self)!
            homeVC.viewModel = r.resolve(HomeViewModel.self)!
            return homeVC
        }
        
        container.register(HomeViewModel.self) { r in
            let homeVM = HomeViewModel()
            homeVM.expositionUseCase = r.resolve(ExpositionUseCase.self)!
            homeVM.radarStatusUseCase = r.resolve(RadarStatusUseCase.self)!
            homeVM.resetDataUseCase = r.resolve(ResetDataUseCase.self)!
            homeVM.syncUseCase = r.resolve(SyncUseCase.self)!
            homeVM.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)!
            return homeVM
        }
        
        container.register(MyDataViewController.self) {  r in
            self.createViewController(storyboard: "MyData", id: "MyDataViewController") as! MyDataViewController
        }
        
        container.register(HelpLineViewController.self) {  r in
            let helpVC = self.createViewController(storyboard: "HelpLine", id: "HelpLineViewController") as! HelpLineViewController
            helpVC.router = r.resolve(AppRouter.self)!
            helpVC.preferencesRepository = r.resolve(PreferencesRepository.self)!
            return helpVC
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
            welcomeVC.localizationRepository = r.resolve(LocalizationRepository.self)!
            welcomeVC.router = r.resolve(AppRouter.self)!
            return welcomeVC
        }
        
        container.register(ActivateCovidNotificationViewController.self) {  r in
            let activateCovidVC = ActivateCovidNotificationViewController()
            activateCovidVC.router = r.resolve(AppRouter.self)!
            activateCovidVC.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)!
            activateCovidVC.radarStatusUseCase = r.resolve(RadarStatusUseCase.self)!
            return activateCovidVC
        }
        
        container.register(ActivatePushNotificationViewController.self) {  r in
            let activatePushVC = ActivatePushNotificationViewController()
            activatePushVC.router = r.resolve(AppRouter.self)!
            activatePushVC.notificationHandler = r.resolve(NotificationHandler.self)
            return activatePushVC
        }
        
        
        container.register(RootViewController.self) { r in
            let rootVC = RootViewController()
            rootVC.ccaaUseCase = r.resolve(CCAAUseCase.self)!
            rootVC.localesUseCase = r.resolve(LocalesUseCase.self)!
            rootVC.configurationUseCasee = r.resolve(ConfigurationUseCase.self)!
            rootVC.localizationUseCase = r.resolve(LocalizationUseCase.self)!
            rootVC.onBoardingCompletedUseCase = r.resolve(OnboardingCompletedUseCase.self)!
            rootVC.router = r.resolve(AppRouter.self)!
            return rootVC
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
