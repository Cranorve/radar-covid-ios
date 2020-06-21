//
//  MyDataViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class MyDataViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTexts()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func loadTexts() {
        let attributedString = NSMutableAttributedString(string: "NO recogemos ningún dato pesonal (nombre, dirección, edad, teléfono, correo electrónico...)\n\nNO recogemos ningún dato de geolocalización, incluidos los datos del GPS\n\nPor tanto:\nNO podemos determinar tu identidad ni saber las personas con las que has estado", attributes: [
          .font: UIFont(name: "Muli-Regular", size: 20.0)!,
          .foregroundColor: UIColor(white: 38.0 / 255.0, alpha: 1.0)
        ])
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-ExtraBold", size: 20.0)!, range: NSRange(location: 0, length: 2))
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-ExtraBold", size: 20.0)!, range: NSRange(location: 93, length: 2))
        attributedString.addAttributes([
          .font: UIFont(name: "Muli-ExtraBold", size: 20.0)!,
          .foregroundColor: UIColor(red: 112.0 / 255.0, green: 80.0 / 255.0, blue: 156.0 / 255.0, alpha: 1.0)
        ], range: NSRange(location: 178, length: 2))
        attributedString.addAttribute(.font, value: UIFont(name: "Muli-Bold", size: 20.0)!, range: NSRange(location: 180, length: 77))
        
        descriptionLabel.attributedText = attributedString
    }
    
}
