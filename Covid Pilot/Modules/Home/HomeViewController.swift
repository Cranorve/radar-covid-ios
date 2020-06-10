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
    
    @IBOutlet weak var expositionTitle: UILabel!
    @IBOutlet weak var expositionDescription: UILabel!
    @IBOutlet weak var expositionView: UIView!
    
    private let disposeBag = DisposeBag()
    
    var router: AppRouter?
    var expositionUseCase: ExpositionUseCase?
    
    @IBAction func onCommunicate(_ sender: Any) {
        router?.route(to: Routes.MyHealth, from: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        expositionUseCase?.getExpositionInfo().subscribe(
            onNext:{ [weak self] expositionInfo in
                self?.updateExpositionInfo(expositionInfo)
            }, onError: {  [weak self] error in

        }).disposed(by: disposeBag)
        
    }
    
    private func updateExpositionInfo(_ exposition: ExpositionInfo) {
        var title = ""
        var description = ""
        switch exposition.level {
            case .HIGH:
                title = "Exposición alta"
                description = "Has estado en contacto con una persona contagiada de Covid-19 . Cuídate y cuida a los demás."
            case .MEDIUM:
                title = "Exposición media"
                description = "Has estado en contacto con una persona contagiada de Covid-19. Cuídate y cuida a los demás."
            case .LOW:
                title = "Exposición baja"
                description = "Te informaremos en el caso de un posible contacto. Cuídate y cuida a los demás."
            case .none:
                title = ""
                description = ""
        }
        expositionTitle.text = title
        expositionDescription.text = description
        gradient(view: expositionView, startColor: .red, endColor: .white)
        
    }
    
    private func gradient(view: UIView, startColor: UIColor, endColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.white.cgColor, UIColor.red.cgColor]
        let y = view.bounds.height / 2
        gradient.startPoint = CGPoint(x: 0, y: y)
        gradient.endPoint = CGPoint(x: view.bounds.width, y: y)
        view.layer.insertSublayer(gradient, at: 0)
    }
    
    

}
