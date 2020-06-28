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
    @IBOutlet weak var radarView: BackgroundView!
    
    @IBOutlet weak var resetDataButton: UIButton!
    
    private var expositionInfo: ExpositionInfo?
    
    var router: AppRouter?
    var expositionUseCase: ExpositionUseCase?
    var radarStatusUseCase: RadarStatusUseCase?
    var syncUseCase: SyncUseCase?
    var resetDataUseCase: ResetDataUseCase?
    
    @IBAction func onCommunicate(_ sender: Any) {
        router?.route(to: Routes.MyHealth, from: self)
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
        switch expositionInfo?.level {
        case .Healthy(lastCheck: let lastCheck):
            guard let lastCheckDate = lastCheck else {
                return
            }
            router?.route(to: Routes.Exposition, from: self, parameters: lastCheckDate)
        case .Exposed(since: let since):
            router?.route(to: Routes.HighExposition, from: self, parameters: since)
        default:
            router?.route(to: Routes.HighExposition, from: self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetDataButton.isHidden = !Config.debug
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onExpositionTap))
        
        expositionView.addGestureRecognizer(gesture)
        radarView.image = UIImage(named: "WhiteCard")
        
        radarSwitch.tintColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        radarSwitch.layer.cornerRadius = radarSwitch.frame.height / 2
        radarSwitch.backgroundColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        
        updateExpositionInfo(ExpositionInfo.init(level: .Healthy(lastCheck: nil)))
        
        let isTracingActive = radarStatusUseCase?.isTracingActive() ?? false
        changeRadarMessage(active: isTracingActive)
        radarSwitch.isOn = isTracingActive
        
        DispatchQueue.main.async {
            self.view.showLoading()
        }
        syncUseCase?.sync().subscribe(
            onNext:{ _ in
                debugPrint("Sync Completed")
            }, onError: { [weak self] error in
                debugPrint(error)
                self?.present(Alert.showAlertOk(title: "Error", message: "Error al obtener datos de exposición", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)
        
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] expositionInfo in
                DispatchQueue.main.async { [weak self] in
                    self?.view.hideLoading()
                }
                self?.updateExpositionInfo(expositionInfo)
            }, onError: { [weak self] error in
                debugPrint(error)
                DispatchQueue.main.async { [weak self] in
                    self?.view.hideLoading()
                }
                self?.present(Alert.showAlertOk(title: "Error", message: "Error al obtener el estado de exposición", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    private func updateExpositionInfo(_ exposition: ExpositionInfo) {
        self.expositionInfo = exposition
        switch exposition.level {
            case .Exposed(since: let since):
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
            case .Healthy(lastCheck: let lastCheck):
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
            default:
                expositionTitle.text = ""
                expositionTitle.textColor = #colorLiteral(red: 0.3449999988, green: 0.6899999976, blue: 0.4160000086, alpha: 1)
                expositionDescription.text = ""
                expositionView.image = bgImageGreen

        }
        
    }
    
    private func changeRadarMessage(active: Bool) {
        if (active) {
            radarMessage.text = "Las interacciones con móviles cercanos se registarán siempre anónimamente. "
            radarMessage.textColor = UIColor.black
        } else {
            radarMessage.text = "Por favor, activa el Bluetooth para poder identificar posibles contagios."
            radarMessage.textColor = #colorLiteral(red: 0.878000021, green: 0.423999995, blue: 0.3409999907, alpha: 1)
        }
    }
    
    
}
