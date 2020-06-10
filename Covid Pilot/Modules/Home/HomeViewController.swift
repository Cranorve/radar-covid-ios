//
//  HomeViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    private let bgImageOrange = UIImage(named: "GradientBackgroundOrange")
    private let bgImageGreen = UIImage(named: "GradientBackgroundGreen")
    
    @IBOutlet weak var expositionTitle: UILabel!
    @IBOutlet weak var expositionDescription: UILabel!
    @IBOutlet weak var expositionView: BackgroundView!
    @IBOutlet weak var radarSwitch: UISwitch!
    @IBOutlet weak var radarMessage: UILabel!
    
    private var expositionInfo: ExpositionInfo?
    
    var router: AppRouter?
    var expositionUseCase: ExpositionUseCase?
    
    @IBAction func onCommunicate(_ sender: Any) {
        router?.route(to: Routes.MyHealth, from: self)
    }
    
    @IBAction func onRadarSwitchChange(_ sender: Any) {
        changeMessage(active: radarSwitch.isOn)
    }
    
    @objc func onExpositionTap() {
        router?.route(to: Routes.Exposition, from: self, parameters: expositionInfo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onExpositionTap))
        
        expositionView.addGestureRecognizer(gesture)
        
        radarSwitch.tintColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        radarSwitch.layer.cornerRadius = radarSwitch.frame.height / 2
        radarSwitch.backgroundColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] expositionInfo in
                self?.updateExpositionInfo(expositionInfo)
            }, onError: {  [weak self] error in

        }).disposed(by: disposeBag)
        
    }
    
    private func updateExpositionInfo(_ exposition: ExpositionInfo) {
        switch exposition.level {
            case .HIGH:
                expositionTitle.text = "Exposición alta"
                expositionDescription.text = "Has estado en contacto con una persona contagiada de Covid-19 . Cuídate y cuida a los demás."
                expositionView.image = bgImageRed
                expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
            case .MEDIUM:
                expositionTitle.text = "Exposición media"
                expositionDescription.text = "Has estado en contacto con una persona contagiada de Covid-19. Cuídate y cuida a los demás."
                expositionView.image = bgImageOrange
                expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
            case .LOW:
                expositionTitle.text = "Exposición baja"
                expositionDescription.text  = "Te informaremos en el caso de un posible contacto. Cuídate y cuida a los demás."
                expositionView.image = bgImageGreen
                expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
            case .none:
                expositionTitle.text = ""
                expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
                expositionDescription.text = ""
                expositionView.image = bgImageGreen
        }
        
    }
    
    private func changeMessage(active: Bool) {
        if (active) {
            radarMessage.text = "Las interacciones con móviles cercanos se registarán siempre anónimamente. "
            radarMessage.textColor = UIColor.black
        } else {
            radarMessage.text = "Por favor, activa el Bluetooth para poder identificar posibles contagios."
            radarMessage.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        }
    }
    
    
}
