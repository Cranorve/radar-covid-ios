//
//  PositiveExposed.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 06/07/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class PositiveExposedViewController: UIViewController {
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    
    @IBOutlet weak var realInfectedText: UILabel!
    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var expositionBGView : BackgroundView!
    var since:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfectedText()
        
        expositionBGView.image = bgImageRed
        
        moreInfoView.isUserInteractionEnabled = true
        moreInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
    }
    
    func setInfectedText() {
        let date = self.since ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let actualizado = formatter.string(from: date)
        
        
        var daysSinceLastInfection = Date().days(sinceDate: since ?? Date()) ?? 1
        if daysSinceLastInfection == 0 {
            daysSinceLastInfection = 1
        }
        realInfectedText.attributedText = "EXPOSITION_EXPOSED_DESCRIPTION".localizedAttributed(withParams: [String(daysSinceLastInfection), actualizado])
    }
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let url = URL(string: "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/ciudadania.htm") else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
