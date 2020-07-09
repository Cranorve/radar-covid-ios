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
    

    @IBOutlet weak var topRadarTitle: NSLayoutConstraint!
    @IBOutlet weak var topActiveNotification: NSLayoutConstraint!
    @IBOutlet weak var imageCircle: UIImageView!
    @IBOutlet weak var envLabel: UILabel!
    @IBOutlet weak var imageDefault: UIImageView!
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var expositionTitle: UILabel!
    @IBOutlet weak var expositionDescription: UILabel!
    @IBOutlet weak var expositionView: BackgroundView!
    @IBOutlet weak var radarSwitch: UISwitch!
    @IBOutlet weak var radarMessage: UILabel!
    @IBOutlet weak var radarTitle: UILabel!
    @IBOutlet weak var radarView: BackgroundView!
    @IBOutlet weak var communicationButton: UIButton!
    @IBOutlet weak var ActivateNotificationButton: UIButton!
    @IBOutlet weak var notificationInactiveMessage: UILabel!
    @IBOutlet weak var resetDataButton: UIButton!
    
    @IBAction func ActivateNotifications(_ sender: Any) {
        self.showCovidAlert()
    }

    
    func showCovidAlert(){
        self.showAlertOk(title: "Notificaciones de exposición a la COVID-19 desactivadas", message: "Para que Radar COVID pueda funcionar, es necesario que actives las notificaciones de exposición a la COVID-19", buttonTitle: "Activar") { (action) in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
    }
    
    
    private var expositionInfo: ExpositionInfo?
    var isColor = true
    var router: AppRouter?
    var expositionUseCase: ExpositionUseCase?
    var radarStatusUseCase: RadarStatusUseCase?
    var syncUseCase: SyncUseCase?
    var resetDataUseCase: ResetDataUseCase?
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    var originalImage: UIImage?
    var originalCircleImage: UIImage?
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
            self.showAlertCancelContinue(title: "¿Estas seguro de desactivar Radar COVID?", message: "Si desactivas Radar COVID, la aplicación dejará de registrar contactos. Ayúdanos a cuidarte" , buttonOkTitle: "Desactivar", buttonCancelTitle: "Mantener activo",
                okHandler: { [weak self] _ in self?.changeRadarStatus(false)
                    self?.imageDefault.image = self?.originalImage?.grayScale
                    self?.imageCircle.image = self?.originalCircleImage?.grayScale

                },
                cancelHandler: { [weak self] _ in self?.radarSwitch.isOn = true
                    self?.imageDefault.image = self?.originalImage
                    self?.imageCircle.image = self?.originalCircleImage

            })
                
        } else {
            changeRadarStatus(active)
        }
        
    }
    
    func changeRadarStatus(_ active: Bool) {
        radarStatusUseCase?.changeTracingStatus(active: active).subscribe(
            onNext:{ [weak self] active in
                self?.changeRadarMessage(active: active)
            }, onError: {  [weak self] error in
                debugPrint(error)
                self?.changeRadarMessage(active: false)
        }).disposed(by: disposeBag)
    }
    
    
    @objc func onExpositionTap() {
        if let level = expositionInfo?.level {
            switch level {
                case .Healthy:
                    router?.route(to: Routes.Exposition, from: self, parameters: expositionInfo?.lastCheck)
                case .Exposed:
                    router?.route(to: Routes.HighExposition, from: self, parameters: expositionInfo?.since)
                case .Infected:
                    router?.route(to: Routes.PositiveExposed, from: self, parameters: expositionInfo?.lastCheck)
                case .Error:
                    debugPrint("Navigate to Error")
            }
        } else {
            router?.route(to: Routes.Exposition, from: self, parameters: Date())
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.originalImage = self.imageDefault.image
        self.originalCircleImage = self.imageCircle.image
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onExpositionTap))
        expositionView.addGestureRecognizer(gesture)
        radarView.image = UIImage(named: "WhiteCard")
        
        radarSwitch.tintColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        radarSwitch.layer.cornerRadius = radarSwitch.frame.height / 2
        radarSwitch.backgroundColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)

        resetDataButton.isHidden = !Config.debug
        if Config.endpoints == .pre {
            envLabel.text = Config.environment
        } else {
            envLabel.text = ""
        }
        
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] expositionInfo in
                self?.updateExpositionInfo(expositionInfo)
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.showAlertOk(title: "Error", message: "Error al obtener el estado de exposición", buttonTitle: "Aceptar")
        }).disposed(by: disposeBag)
        
        //get current exposition info in repository
        self.updateExpositionInfo((expositionUseCase?.getExpositionInfoFromRepository())!)
        
        checkOnboarding()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        radarStatusUseCase?.restoreLastStateAndSync().subscribe(
            onNext:{ [weak self] isTracingActive in
                self?.changeRadarMessage(active: isTracingActive)
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.changeRadarMessage(active: false)
        }).disposed(by: disposeBag)
        
        //Remove comminication covid button if already infected
        if (expositionInfo?.level == .Infected ){
            self.communicationButton.isHidden = true
        }
    }
    
    @IBAction func onReset(_ sender: Any) {
        
        self.showAlertCancelContinue(title:  "Confirmación", message: "¿Confirmas el reseteo?", buttonOkTitle: "OK", buttonCancelTitle: "Cancelar") { [weak self] (UIAlertAction) in
            self?.reset()
        }

    }
    
    private func reset() {
        resetDataUseCase?.reset().subscribe(
                onNext:{ [weak self] expositionInfo in
                    debugPrint("Data reseted")
                    self?.showAlertOk(title: "Reset", message: "Datos reseteados", buttonTitle: "Aceptar")
                }, onError: { [weak self] error in
                    debugPrint(error)
                    self?.showAlertOk(title: "Error", message: "Error resetear datos", buttonTitle: "Aceptar")
            }).disposed(by: disposeBag)
    }
    
    private func updateExpositionInfo(_ exposition: ExpositionInfo) {
                
        self.expositionInfo = exposition
        switch exposition.level {
            case .Exposed:
                expositionTitle.text = "Exposición alta"
               let attributedString = NSMutableAttributedString(string: "Has estado en contacto con una persona contagiada de Covid-19.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas", attributes: [
                  .font: UIFont(name: "Muli-Light", size: 16.0)!,
                  .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
                ])
                attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 63))
                expositionDescription.attributedText  = attributedString
                expositionView.image = bgImageRed
                expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
                notificationInactiveMessage.isHidden = true
                ActivateNotificationButton.isHidden = true
                topActiveNotification.priority = .defaultLow
                topRadarTitle.priority = .defaultHigh
                self.imageDefault.image = self.originalImage
                self.imageCircle.image = self.originalCircleImage
                break
            case .Healthy:
                expositionTitle.text = "Exposición baja"
                let attributedString = NSMutableAttributedString(string: "Te informaremos en el caso de un\nposible contacto de riesgo.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas.", attributes: [
                  .font: UIFont(name: "Muli-Light", size: 16.0)!,
                  .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
                ])
                attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 61))
                
                expositionDescription.attributedText  = attributedString
                expositionView.image = bgImageGreen
                expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
                notificationInactiveMessage.isHidden = true
                ActivateNotificationButton.isHidden = true
                topActiveNotification.priority = .defaultLow
                topRadarTitle.priority = .defaultHigh
                self.imageDefault.image = self.originalImage
                self.imageCircle.image = self.originalCircleImage
                break
            case .Infected:
                expositionTitle.text = "COVID-19 Positivo"
                let attributedString = "<b>Tu diagnóstico ha sido enviado.<br>Por favor, aíslate durante 14 días</b>.<br> Recuerda que esta aplicación es un piloto y sus alertas son simuladas".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)
                expositionDescription.attributedText  = attributedString
                expositionView.image = bgImageRed
                expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
                notificationInactiveMessage.isHidden = true
                ActivateNotificationButton.isHidden = true
                topActiveNotification.priority = .defaultLow
                topRadarTitle.priority = .defaultHigh
                self.imageDefault.image = self.originalImage
                self.imageCircle.image = self.originalCircleImage
                break;

            case .Error:
                expositionTitle.text = "Exposición baja"
                let attributedString = NSMutableAttributedString(string: "Te informaremos en el caso de un\nposible contacto de riesgo.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas.", attributes: [
                  .font: UIFont(name: "Muli-Light", size: 16.0)!,
                  .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
                ])
                attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 61))
                
                expositionDescription.attributedText  = attributedString
                expositionView.image = bgImageGreen
                expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
                notificationInactiveMessage.isHidden = false
                ActivateNotificationButton.isHidden = false
                topActiveNotification.priority = .defaultHigh
                topRadarTitle.priority = .defaultLow
                self.imageDefault.image = self.originalImage?.grayScale
                self.imageCircle.image = self.originalCircleImage?.grayScale
        }
        
    }
    
    private func changeRadarMessage(active: Bool) {
        radarSwitch.isOn = active
        if (active) {
            radarTitle.text = "Radar COVID activo"
            radarMessage.text = "Las interacciones con móviles cercanos se registarán siempre anónimamente. "
            radarMessage.textColor = UIColor.black
        } else {
            radarTitle.text = "Radar COVID inactivo"
            radarMessage.text = "Por favor, activa esta opción para poder identificar posibles contagios."
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
