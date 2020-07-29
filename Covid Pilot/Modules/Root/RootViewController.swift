//
//  RootViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 10/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class RootViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    var router: AppRouter?
    var configurationUseCasee: ConfigurationUseCase?
    var ccaaUseCase: CCAAUseCase?
    var localizationUseCase: LocalizationUseCase?
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?

    override func viewDidLoad() {
        super.viewDidLoad()

        LocalizationHolder.source = localizationUseCase
        
        ccaaUseCase!.loadCCAA().subscribe(onNext:{ ccaas in
                debugPrint(ccaas)
            }, onError: {  error in
                debugPrint(error)
        }).disposed(by: self.disposeBag)
        
        localizationUseCase!.loadlocalization().subscribe(
            onNext:{ [weak self] active in
                self?.loadConfiguration()
            }, onError: {  [weak self]  error in
                debugPrint(error)

                // Not use i18n for this alert!
                self?.showAlertOk(title: "Error", message: "Se ha producido un error. Compruebe la conexión", buttonTitle: "Aceptar") { (action) in
                    exit(0)
                }
        }).disposed(by: self.disposeBag)

    }
    
    private func loadConfiguration() {
        configurationUseCasee!.loadConfig().subscribe(
            onNext:{ [weak self] settings in
                debugPrint("Configuration  finished")

                if  (settings.isUpdated ?? false) {
                    self?.navigateFirst()
                } else {
                    let configUrl = settings.parameters?.applicationVersion?.ios?.bundleUrl ?? "itms://itunes.apple.com"
                    self?.showAlertOk(title: "ALERT_UPDATE_TEXT_TITLE".localizedAttributed.string,
                                      message: "ALERT_UPDATE_TEXT_CONTENT".localizedAttributed.string,
                                      buttonTitle: "ALERT_UPDATE_BUTTON".localizedAttributed.string) { (action) in
                        if let url = NSURL(string: configUrl) as URL? {
                            UIApplication.shared.open(url) { (open) in
                                exit(0)
                            }
                        }
                    }
                }
                
            }, onError: {  [weak self] error in
                debugPrint("Configuration errro \(error)")
                self?.showAlertOk(title: "ALERT_GENERIC_ERROR_TITLE".localizedAttributed.string, message: "ALERT_GENERIC_ERROR_CONTENT".localizedAttributed.string, buttonTitle: "ALERT_ACCEPT_BUTTON".localizedAttributed.string) { (action) in
                    self?.navigateFirst()
                }
                
        }).disposed(by: disposeBag)
    }

    private func navigateFirst() {
        if (onBoardingCompletedUseCase?.isOnBoardingCompleted() ?? false) {
            router?.route(to: Routes.Home, from: self)
        } else {
            router!.route(to: Routes.Welcome, from: self)
        }
    }

}
