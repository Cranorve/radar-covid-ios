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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var acceptView: UIView!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    @IBAction func onOk(_ sender: Any) {
        router?.route(to: Routes.Proximity, from:self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.acceptTermsLabel.attributedText = "He leído las <b><u>condiciones de uso</u></b>".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)
        self.privacyLabel.attributedText = "Acepto la <b><u>política de privacidad </u></b>".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli-Light", andSize: 16)

        acceptButton.isEnabled = termsAccepted
        scrollView.alwaysBounceVertical = false
        
        loadTexts()
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
    
    private func loadTexts() {
        let attributedString = NSMutableAttributedString(string: "Nuestros compromisos\n\nAnonimato \nLa aplicación funciona sin revelar tu identidad ni la de tu smartphone. \nNO se recoge tu nombre, email, geolocalización, ni tu teléfono.\n\nDiscreción \nLas alertas de exposición se envían sin indicar cuándo y dónde se produjo la exposición.\n\nTú decides\nElige en todo momento si quieres desactivar el servicio o dejar de utilizar la App.", attributes: [
          .font: UIFont(name: "Muli-Light", size: 20.0)!,
          .foregroundColor: UIColor(white: 0.0, alpha: 1.0)
        ])
        attributedString.addAttributes([
          .font: UIFont(name: "Muli-Bold", size: 22.0)!,
          .foregroundColor: UIColor(red: 112.0 / 255.0, green: 80.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0)
        ], range: NSRange(location: 0, length: 21))
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-ExtraBold", size: 20.0)!, range: NSRange(location: 21, length: 12))
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-ExtraBold", size: 20.0)!, range: NSRange(location: 106, length: 2))
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-ExtraBold", size: 20.0)!, range: NSRange(location: 170, length: 13))
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-ExtraBold", size: 20.0)!, range: NSRange(location: 273, length: 11))
        
        descriptionLabel.attributedText = attributedString
        
    }

}
