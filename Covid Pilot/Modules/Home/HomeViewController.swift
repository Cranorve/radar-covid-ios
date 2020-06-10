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
    
    @IBOutlet weak var expositionTitle: UILabel!
    @IBOutlet weak var expositionDescription: UILabel!
    @IBOutlet weak var expositionView: UIView!
    
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
//        expositionView.colors =  [UIColor.white.cgColor, UIColor.red.cgColor]
        
    }
    

}
