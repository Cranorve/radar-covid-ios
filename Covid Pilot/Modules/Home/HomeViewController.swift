//
//  HomeViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift
import DP3TSDK

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    private let bgImageOrange = UIImage(named: "GradientBackgroundOrange")
    private let bgImageGreen = UIImage(named: "GradientBackgroundGreen")
    
    @IBOutlet weak var imageDefault: UIImageView!
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var expositionTitle: UILabel!
    @IBOutlet weak var expositionDescription: UILabel!
    @IBOutlet weak var expositionView: BackgroundView!
    @IBOutlet weak var radarSwitch: UISwitch!
    @IBOutlet weak var radarMessage: UILabel!
    @IBOutlet weak var radarTitle: UILabel!
    @IBOutlet weak var radarView: BackgroundView!
    
    @IBOutlet weak var resetDataButton: UIButton!
    
    private var expositionInfo: ExpositionInfo?
    
    var router: AppRouter?
    var expositionUseCase: ExpositionUseCase?
    var radarStatusUseCase: RadarStatusUseCase?
    var syncUseCase: SyncUseCase?
    var resetDataUseCase: ResetDataUseCase?
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    
    @IBAction func onCommunicate(_ sender: Any) {
        guard let expositionInfo = expositionInfo else {
            return
        }
        if (expositionInfo.level == .Infected) {
            router?.route(to: Routes.MyHealthReported, from: self)
        } else {
            router?.route(to: Routes.MyHealth, from: self)
        }
        
    }
    
    @IBAction func onRadarSwitchChange(_ sender: Any) {
        
        let active = radarSwitch.isOn
        
        if !active {
            let alert = Alert.showAlertCancelContinue(title: "¿Estas seguro?", message: "Si desactivas Radar COVID (el Bluetooth), no podremos avisarte." , buttonOkTitle: "Continuar", buttonCancelTitle: "Cancelar",
                okHandler: { [weak self] _ in self?.changeRadarStatus(false)},
                cancelHandler: { [weak self] _ in self?.radarSwitch.isOn = true})
        
            present(alert, animated: true)
                
        } else {
            changeRadarStatus(active)
        }
        
    }
    
    func changeRadarStatus(_ active: Bool) {
        radarStatusUseCase?.changeTracingStatus(active: active).subscribe(
            onNext:{ [weak self] active in
                self?.changeRadarMessage(active: active)
            }, onError: {  [weak self] error in
                debugPrint("Error: \(error)")
                self?.radarSwitch.isOn = false
                self?.changeRadarMessage(active: (self?.radarSwitch.isOn)!)
        }).disposed(by: disposeBag)
    }
    
    @objc func onExpositionTap() {
        if let level = expositionInfo?.level {
            switch level {
                case .Healthy(lastCheck: let lastCheck):
                    router?.route(to: Routes.Exposition, from: self, parameters: lastCheck)
                case .Exposed(since: let since):
                    router?.route(to: Routes.HighExposition, from: self, parameters: since)
                case .Infected:
                    router?.route(to: Routes.MyHealthReported, from: self)
            }
        } else {
            router?.route(to: Routes.Exposition, from: self, parameters: Date())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkOnboarding()
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onExpositionTap))
        
        expositionView.addGestureRecognizer(gesture)
        radarView.image = UIImage(named: "WhiteCard")
        
        radarSwitch.tintColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        radarSwitch.layer.cornerRadius = radarSwitch.frame.height / 2
        radarSwitch.backgroundColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        
        updateExpositionInfo(ExpositionInfo.init(level: .Healthy(lastCheck: nil)))

        resetDataButton.isHidden = !Config.debug
        
        syncUseCase?.sync().subscribe(
            onError: { [weak self] error in
                self?.present(Alert.showAlertOk(title: "Error", message: "Error al obtener datos de exposición", buttonTitle: "Aceptar"), animated: true)
            }, onCompleted: {
                debugPrint("Sync Completed")
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isTracingActive = radarStatusUseCase?.isTracingActive() ?? false
        changeRadarMessage(active: isTracingActive)
        radarSwitch.isOn = isTracingActive
        
        self.view.showLoading()
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] expositionInfo in
                self?.view.hideLoading()
                self?.updateExpositionInfo(expositionInfo)
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.view.hideLoading()
                self?.present(Alert.showAlertOk(title: "Error", message: "Error al obtener el estado de exposición", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    @IBAction func onReset(_ sender: Any) {
        
        present(Alert.showAlertCancelContinue(title:  "Confirmación", message: "¿Confirmas el reseteo?", buttonOkTitle: "OK", buttonCancelTitle: "Cancelar") { [weak self] (UIAlertAction) in
            self?.reset()
        },animated: true)

    }
    
    private func reset() {
        resetDataUseCase?.reset().subscribe(
                onNext:{ [weak self] expositionInfo in
                    debugPrint("Data reseted")
                    self?.present(Alert.showAlertOk(title: "Reset", message: "Datos reseteados", buttonTitle: "Aceptar"), animated: true)
                }, onError: { [weak self] error in
                    debugPrint(error)
                    self?.present(Alert.showAlertOk(title: "Error", message: "Error resetear datos", buttonTitle: "Aceptar"), animated: true)
            }).disposed(by: disposeBag)
    }
    
    private func updateExpositionInfo(_ exposition: ExpositionInfo) {
        
        guard (exposition.level != nil) else {
            return
        }
        
        self.expositionInfo = exposition
        switch exposition.level {
            case .Exposed(since: _):
                expositionTitle.text = "Exposición alta"
               let attributedString = NSMutableAttributedString(string: "Has estado en contacto con una persona contagiada de Covid-19.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas", attributes: [
                  .font: UIFont(name: "Muli-Light", size: 16.0)!,
                  .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
                ])
                attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 63))
                expositionDescription.attributedText  = attributedString
                expositionView.image = bgImageRed
                expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
                break
            case .Healthy(lastCheck: _):
                expositionTitle.text = "Exposición baja"
                let attributedString = NSMutableAttributedString(string: "Te informaremos en el caso de un\nposible contacto de riesgo.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas.", attributes: [
                  .font: UIFont(name: "Muli-Light", size: 16.0)!,
                  .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
                ])
                attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 61))
                
                expositionDescription.attributedText  = attributedString
                expositionView.image = bgImageGreen
                expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
                break
            case .Infected:
                expositionTitle.text = "COVID-19 Positivo"
                let attributedString = "<b>Tu diagnóstico ha sido enviado.<br>Por favor, aíslate durante 14 días</b>.<br> Recuerda que esta aplicación es un piloto y sus alertas son simuladas".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)
                expositionDescription.attributedText  = attributedString
                expositionView.image = bgImageRed
                expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
                break;
            

            default:
                expositionTitle.text = ""
                expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
                expositionDescription.text = ""
                expositionView.image = bgImageGreen

        }
        
    }
    
    private func changeRadarMessage(active: Bool) {
        if (active) {
            radarTitle.text = "Radar COVID activo"
            radarMessage.text = "Las interacciones con móviles cercanos se registarán siempre anónimamente. "
            radarMessage.textColor = UIColor.black
        } else {
            radarTitle.text = "Radar COVID inactivo"
            radarMessage.text = "Por favor, activa el Bluetooth para poder identificar posibles contagios."
            radarMessage.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        }
    }
    
    private func checkOnboarding() {
        //show check image 1.5 sec
        if !(self.onBoardingCompletedUseCase?.isOnBoardingCompleted() ?? true) {
            imageCheck.isHidden = false
            imageDefault.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //Update UI
                
                self.onBoardingCompletedUseCase?.setOnboarding(completed: true)
                
                self.imageCheck.isHidden = true
                self.imageDefault.isHidden = false
                
            }
        }
    }
    
}
