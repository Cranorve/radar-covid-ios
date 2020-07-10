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
    var localizationUseCase: LocalizationUseCase?
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?

    override func viewDidLoad() {
        super.viewDidLoad()

        LocalizationHolder.source = localizationUseCase
        
        localizationUseCase!.loadlocalization().subscribe(
            onNext:{ [weak self] active in
                debugPrint("Ok")
                self?.navigateFirst()
            }, onError: {  [weak self]  error in
                debugPrint(error)
                self?.navigateFirst()
        }).disposed(by: self.disposeBag)
        
        configurationUseCasee!.loadConfig().subscribe(
            onNext:{ [weak self] settings in
                debugPrint("Configuration  finished")

                if  !(settings.isUpdated ?? false) {
                    let configUrl = settings.parameters?.applicationVersion?.ios?.bundleUrl ?? "itms://itunes.apple.com"
                    self?.showAlertOk(title: "Error", message: "Para poder seguir utilizando Radar COVID es necesario que actualices la aplicación.", buttonTitle: "ACTUALIZAR") { (action) in
                        if let url = NSURL(string: configUrl) as URL? {
                            UIApplication.shared.open(url) { (open) in
                                exit(0);
                            }
                        }
                    }
                }
                
            }, onError: {  [weak self] error in
                debugPrint("Configuration errro \(error)")
                self?.showAlertOk(title: "Error", message: "Se ha producido un error. Compruebe la conexión", buttonTitle: "Aceptar")
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
