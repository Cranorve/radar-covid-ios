//
//  OnBoardingViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController {
    
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    var router: AppRouter?
    
    private var termsAccepted: Bool = false

    @IBOutlet weak var checkBoxImage: UIImageView!
   
    @IBOutlet weak var acceptTermsLabel: UILabel!
    
    @IBOutlet weak var reminderAcceptTermsView: UIView!
    
    
    @IBAction func onOk(_ sender: Any) {
        if (!termsAccepted){
            //show reminder view
            
        }
        else {
            
            router?.route(to: Routes.Info, from:self)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        if (onBoardingCompletedUseCase?.isOnBoardingCompleted() ?? false) {
            router?.route(to: Routes.Home, from: self)
        }
//        router?.route(to: Routes.Home, from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding tapgesture to the Accept terms checkboxImage and label
        acceptTermsLabel.isUserInteractionEnabled = true
        checkBoxImage.isUserInteractionEnabled = true
        acceptTermsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
        checkBoxImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))

    }
    
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        if (!termsAccepted) {
            checkBoxImage.image = UIImage(named:"CheckboxSelected")
            termsAccepted = true
        }
        else {
            checkBoxImage.image = UIImage(named:"CheckboxUnselected")
            termsAccepted = false
        }
    }

}
