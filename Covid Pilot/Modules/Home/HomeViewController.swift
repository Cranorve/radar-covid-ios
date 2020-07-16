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
import RxCocoa


class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    private let bgImageOrange = UIImage(named: "GradientBackgroundOrange")
    private let bgImageGreen = UIImage(named: "GradientBackgroundGreen")
    private let imageHomeGray = UIImage(named: "imageHome")?.grayScale
    private let imageHome = UIImage(named: "imageHome")
    private let circle = UIImage(named: "circle")
    private let circleGray = UIImage(named: "circle")?.grayScale

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
    @IBOutlet weak var activateNotificationButton: UIButton!
    @IBOutlet weak var notificationInactiveMessage: UILabel!
    @IBOutlet weak var resetDataButton: UIButton!
    
    var router: AppRouter?
    var viewModel: HomeViewModel?

    @IBAction func ActivateNotifications(_ sender: Any) {
        self.showActivationMessage()
    }
    
    @IBAction func onCommunicate(_ sender: Any) {
        guard let expositionInfo = try? viewModel?.expositionInfo.value() else {
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
        
        if active {
            viewModel?.changeRadarStatus(true)
        } else {
            self.showAlertCancelContinue(title: "¿Estas seguro de desactivar Radar COVID?", message: "Si desactivas Radar COVID, la aplicación dejará de registrar contactos. Ayúdanos a cuidarte" , buttonOkTitle: "Desactivar", buttonCancelTitle:  "Mantener activo",
                okHandler: { [weak self] _ in
                    self?.viewModel?.changeRadarStatus(false)
                }, cancelHandler: { [weak self] _ in
                    self?.radarSwitch.isOn = true
            })
        }
    }
    
    func showActivationMessage() {
        self.showAlertOk(title: "Notificaciones de exposición a la COVID-19 desactivadas", message: "Para que Radar COVID pueda funcionar, es necesario que actives las notificaciones de exposición a la COVID-19", buttonTitle: "Activar") { (action) in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
    }
    
    @objc func onExpositionTap() {
        if let level =  try? viewModel?.expositionInfo.value() {
            navigateToDetail(level)
        }
    }
    
    private func navigateToDetail(_ info: ExpositionInfo) {
        switch info.level {
            case .Healthy:
                router?.route(to: Routes.Exposition, from: self, parameters: info.lastCheck)
            case .Exposed:
                router?.route(to: Routes.HighExposition, from: self, parameters: info.since)
            case .Infected:
                router?.route(to: Routes.PositiveExposed, from: self, parameters: info.lastCheck)
            case .Error:
                debugPrint("Error level should not be here")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        
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
        
        viewModel!.checkInitialExposition()
        
        viewModel!.checkOnboarding()
        
    }
    
    private func setupBindings() {
        viewModel?.radarStatus.subscribe { [weak self] active in
            self?.changeRadarMessage(active: active.element ?? false)
        }.disposed(by: disposeBag)
        
        viewModel?.expositionInfo.subscribe { [weak self] exposition in
            self?.updateExpositionInfo(exposition.element)
        }.disposed(by: disposeBag)
        
        viewModel?.errorMessage.subscribe { [weak self] message in
            self?.showError(message: message.element)
        }.disposed(by: disposeBag)
        
        viewModel?.alertMessage.subscribe { [weak self] message in
            self?.showAlert(message: message.element)
        }.disposed(by: disposeBag)
        
        viewModel?.checkState.subscribe { [weak self] showCheck in
            self?.showCheckState(showCheck.element)
        }.disposed(by: disposeBag)
        
        viewModel!.errorState.subscribe { [weak self] error in
            self?.setErrorState(error.element ?? nil)
        }.disposed(by: disposeBag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.restoreLastStateAndSync()
    }
    
    @IBAction func onReset(_ sender: Any) {
        
        self.showAlertCancelContinue(title:  "Confirmación", message: "¿Confirmas el reseteo?", buttonOkTitle: "OK", buttonCancelTitle: "Cancelar") { [weak self] (UIAlertAction) in
            self?.viewModel!.reset()
        }

    }
    
    private func updateExpositionInfo(_ exposition: ExpositionInfo?) {
        guard let exposition = exposition else {
            return
        }
        switch exposition.level {
            case .Exposed:
                setExposed()
            case .Healthy:
                setHealthy()
            case .Infected:
                setInfected()
            default:
                debugPrint("Error Exposition Level")
        }
    }
    
    private func setExposed() {
        expositionTitle.text = "Exposición alta"
        let attributedString = NSMutableAttributedString(string: "Has estado en contacto con una persona contagiada de COVID-19.\nInfórmalo en el \(Config.contactNumber) (gratuito). \nRecuerda que esta aplicación es un piloto y sus alertas son simuladas", attributes: [
          .font: UIFont(name: "Muli-Light", size: 16.0)!,
          .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 63))
        expositionDescription.attributedText  = attributedString
        expositionView.image = bgImageRed
        expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        communicationButton.isHidden = false
    }
    
    private func setHealthy() {
        expositionTitle.text = "Exposición baja"
        let attributedString = NSMutableAttributedString(string: "Te informaremos en el caso de un\nposible contacto de riesgo.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas.", attributes: [
          .font: UIFont(name: "Muli-Light", size: 16.0)!,
          .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 61))
        
        expositionDescription.attributedText  = attributedString
        expositionView.image = bgImageGreen
        expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
        communicationButton.isHidden = false
    }
    
    private func setInfected() {
        expositionTitle.text = "COVID-19 Positivo"
        let attributedString = "<b>Tu diagnóstico ha sido enviado.<br>Por favor, aíslate durante 14 días</b>.<br> Recuerda que esta aplicación es un piloto y sus alertas son simuladas".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)
        expositionDescription.attributedText  = attributedString
        expositionView.image = bgImageRed
        expositionTitle.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        communicationButton.isHidden = true
    }
    
    private func setErrorState(_ error: DomainError?) {

        if let error = error {
            notificationInactiveMessage.isHidden = false
            activateNotificationButton.isHidden = false
            topActiveNotification.priority = .defaultHigh
            topRadarTitle.priority = .defaultLow
            setImagesInactive(true)
        } else {
            notificationInactiveMessage.isHidden = true
            activateNotificationButton.isHidden = true
            topActiveNotification.priority = .defaultLow
            topRadarTitle.priority = .defaultHigh
            setImagesInactive(false)
        }
    }
    
    private func setImagesInactive(_ inactive: Bool) {
        if inactive {
            imageDefault.image = imageHomeGray
            imageCircle.image = circleGray
        } else {
            imageDefault.image = imageHome
            imageCircle.image = circle
        }
    }
    
    private func changeRadarMessage(active: Bool) {
        radarSwitch.isOn = active
        setImagesInactive(!active)
        if (active) {
            radarTitle.text = "Radar COVID activo"
            radarMessage.text = "Las interacciones con móviles cercanos se registarán siempre anónimamente. "
            radarMessage.textColor = UIColor.black
        } else {
            radarTitle.text = "Radar COVID inactivo"
            radarMessage.text = "Por favor, activa esta opción para que la aplicación funcione."
            radarMessage.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        }
    }
    
    private func showError(message: String?) {
        if let message = message {
            showAlertOk(title: "Error", message: message, buttonTitle: "Aceptar")
        }
    }
    
    private func showAlert(message:String?) {
        if let message = message {
            showAlertOk(title: "Mensaje", message: message, buttonTitle: "Aceptar")
        }
    }
    
    private func showCheckState(_ showCheck: Bool?) {
        let showCheck = showCheck ?? false
        imageCheck.isHidden = !showCheck
        imageDefault.isHidden = showCheck
    }
}
