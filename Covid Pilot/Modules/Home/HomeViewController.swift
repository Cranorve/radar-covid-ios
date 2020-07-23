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
    
    
    @IBAction func ActivateNotifications(_ sender: Any) {
        self.showCovidAlert()
    }
    
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
            self.showAlertCancelContinue(title: "ALERT_HOME_RADAR_TITLE".localizedAttributed.string, message: "ALERT_HOME_RADAR_CONTENT".localizedAttributed.string , buttonOkTitle: "ALERT_HOME_RADAR_OK_BUTTON".localizedAttributed.string, buttonCancelTitle: "ALERT_HOME_RADAR_CANCEL_BUTTON".localizedAttributed.string,
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
    
    func showCovidAlert(){
        self.showAlertOk(title: "HOME_NOTIFICATION_INACTIVE_MESSAGE".localizedAttributed.string, message: "Para que Radar COVID pueda funcionar, es necesario que actives las notificaciones de exposición a la COVID-19", buttonTitle: "ALERT_HOME_COVID_NOTIFICATION_OK_BUTTON".localizedAttributed.string) { (action) in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
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
            navigateToDetail(level)
        } else {
            router?.route(to: Routes.Exposition, from: self, parameters: Date())
        }
    }
    
    private func navigateToDetail(_ level: ExpositionInfo.Level) {
        switch level {
            case .Healthy:
                router?.route(to: Routes.Exposition, from: self, parameters: expositionInfo?.lastCheck)
            case .Exposed:
                router?.route(to: Routes.HighExposition, from: self, parameters: expositionInfo?.since)
            case .Infected:
                router?.route(to: Routes.PositiveExposed, from: self, parameters: expositionInfo?.lastCheck)
            case .Error:
                navigateToDetail(expositionUseCase?.getExpositionInfoFromRepository()?.level ?? .Healthy)
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
        
        envLabel.isHidden = Config.endpoints == .pro
        
        //get current exposition info in repository
        if let exposition = expositionUseCase?.getExpositionInfoFromRepository() {
            self.updateExpositionInfo(exposition)
        }
        
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] expositionInfo in
                self?.updateExpositionInfo(expositionInfo)
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.showAlertOk(title: "ALERT_GENERIC_ERROR_TITLE".localizedAttributed.string, message: "ALERT_HOME_EXPOSITION_CONTENT".localizedAttributed.string, buttonTitle: "ALERT_ACCEPT_BUTTON".localizedAttributed.string)
        }).disposed(by: disposeBag)
        
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
        
        self.showAlertCancelContinue(title:  "ALERT_HOME_RESET_TITLE".localizedAttributed.string, message: "ALERT_HOME_RESET_CONTENT".localizedAttributed.string, buttonOkTitle: "ALERT_OK_BUTTON".localizedAttributed.string, buttonCancelTitle: "ALERT_CANCEL_BUTTON".localizedAttributed.string) { [weak self] (UIAlertAction) in
            self?.reset()
        }

    }
    
    private func reset() {
        resetDataUseCase?.reset().subscribe(
                onNext:{ [weak self] expositionInfo in
                    debugPrint("Data reseted")
                    self?.showAlertOk(title: "ALERT_HOME_RESET_TITLE".localizedAttributed.string, message: "ALERT_HOME_RESET_SUCCESS_CONTENT".localizedAttributed.string, buttonTitle: "ALERT_ACCEPT_BUTTON".localizedAttributed.string)
                }, onError: { [weak self] error in
                    debugPrint(error)
                    self?.showAlertOk(title: "ALERT_GENERIC_ERROR_TITLE".localizedAttributed.string, message: "ALERT_HOME_RESET_ERROR_CONTENT".localizedAttributed.string, buttonTitle: "ALERT_ACCEPT_BUTTON".localizedAttributed.string)
            }).disposed(by: disposeBag)
    }
    
    private func updateExpositionInfo(_ exposition: ExpositionInfo) {
                
        self.expositionInfo = exposition
        switch exposition.level {
            case .Exposed:
                expositionTitle.text = "HOME_EXPOSITION_TITLE_HIGH".localizedAttributed.string
//               let attributedString = NSMutableAttributedString(string: "Has estado en contacto con una persona contagiada de Covid-19.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas", attributes: [
//                  .font: UIFont(name: "Muli-Light", size: 16.0)!,
//                  .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
//                ])
//                attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 63))
                expositionDescription.attributedText  = "HOME_EXPOSITION_MESSAGE_HIGH".localizedAttributed(withParams: ["90000000"])
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
                expositionTitle.text = "HOME_EXPOSITION_TITLE_LOW".localizedAttributed.string
//                let attributedString = NSMutableAttributedString(string: "Te informaremos en el caso de un\nposible contacto de riesgo.\nRecuerda que esta aplicación es un piloto y sus alertas son simuladas.", attributes: [
//                  .font: UIFont(name: "Muli-Light", size: 16.0)!,
//                  .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
//                ])
//                attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 16.0)!, range: NSRange(location: 0, length: 61))
                
                expositionDescription.attributedText  = "HOME_EXPOSITION_MESSAGE_LOW".localizedAttributed
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
                expositionTitle.text = "HOME_EXPOSITION_TITLE_POSITIVE".localizedAttributed.string
//                let attributedString = "<b>Tu diagnóstico ha sido enviado.<br>Por favor, aíslate durante 14 días</b>.<br> Recuerda que esta aplicación es un piloto y sus alertas son simuladas".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)
                expositionDescription.attributedText  = "HOME_EXPOSITION_MESSAGE_INFECTED".localizedAttributed
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
            radarTitle.text = "HOME_RADAR_TITLE_ACTIVE".localizedAttributed.string
            radarMessage.text = "HOME_RADAR_CONTENT_ACTIVE".localizedAttributed.string
            radarMessage.textColor = UIColor.black
        } else {
            radarTitle.text = "HOME_RADAR_TITLE_INACTIVE".localizedAttributed.string
            radarMessage.text = "HOME_RADAR_CONTENT_INACTIVE".localizedAttributed.string
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
