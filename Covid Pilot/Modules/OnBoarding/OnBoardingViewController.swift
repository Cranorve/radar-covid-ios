//
//  OnBoardingViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import SafariServices

class OnBoardingViewController: UIViewController {
    
    var router: AppRouter?
    
    private var termsAccepted: Bool = false

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var checkBoxImage: UIImageView!
   
    @IBOutlet weak var acceptTermsLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    
    @IBOutlet weak var acceptView: UIView!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBAction func onOk(_ sender: Any) {
        router?.route(to: Routes.Info, from:self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.acceptTermsLabel.attributedText = "He leído las <b><u>condiciones de uso</u></b>".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)
        self.privacyLabel.attributedText = "Acepto la <b><u>política de privacidad </u></b>".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)

        acceptButton.isEnabled = termsAccepted
        scrollView.alwaysBounceVertical = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Adding tapgesture to the Accept terms checkboxImage and label
        acceptTermsLabel.isUserInteractionEnabled = true
        privacyLabel.isUserInteractionEnabled = true
        acceptView.isUserInteractionEnabled = true
        
        
        acceptView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapAccept(tapGestureRecognizer:))))
        
        acceptTermsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapTerms(tapGestureRecognizer:))))
        
        privacyLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapPrivacy(tapGestureRecognizer:))))

    }
    
    
    @objc func userDidTapAccept(tapGestureRecognizer: UITapGestureRecognizer) {
        if (!termsAccepted) {
            checkBoxImage.image = UIImage(named:"CheckboxSelected")
            
            termsAccepted = true
        }
        else {
            checkBoxImage.image = UIImage(named:"CheckboxUnselected")
            termsAccepted = false
        }
        acceptButton.isEnabled = termsAccepted
    }
    
    @objc func userDidTapTerms(tapGestureRecognizer: UITapGestureRecognizer) {
        let urlString = "https://radarcovid.covid19.gob.es/terms-of-service/use-conditions.html"
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    
    @objc func userDidTapPrivacy(tapGestureRecognizer: UITapGestureRecognizer) {
        let urlString = "https://radarcovid.covid19.gob.es/terms-of-service/privacy-policy.html"
        if let url = URL(string: urlString) {
            let config = SFSafariViewController.Configuration()
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }

}
