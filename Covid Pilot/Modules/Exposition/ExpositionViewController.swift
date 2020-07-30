//
//  ExpositionViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class ExpositionViewController: BaseExposed {

    private let bgImageGreen = UIImage(named: "GradientBackgroundGreen")
    @IBOutlet weak var sincontactos: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.sincontactos.attributedText = "EXPOSITION_LOW_DESCRIPTION".localizedAttributed(withParams: [expositionDateWithFormat()])
        
//        self.expositionDate.text = "(actualizado \(expositionDateWithFormat()))"
        expositionBGView.image = bgImageGreen
        
        super.viewDidLoad()
    }
    
    func expositionDateWithFormat() -> String{
        if let date = self.lastCheck  {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYYY"
            return formatter.string(from: date)
        }
        return "01.07.2020"
    }
    
   

    
}
