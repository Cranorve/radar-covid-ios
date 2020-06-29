//
//  HighExpositionViewController.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 11/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class HighExpositionViewController: UIViewController {
    
    private let bgImageRed = UIImage(named: "GradientBackgroundRed")
    
    @IBOutlet weak var infectedText: UILabel!
    @IBOutlet weak var phoneView: BackgroundView!
    @IBOutlet weak var timeTableLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var expositionBGView : BackgroundView!
    var since:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infectedText.attributedText = setInfectedText()
        
        expositionBGView.image = bgImageRed
        
        moreInfoView.isUserInteractionEnabled = true
        moreInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
        phoneView.isUserInteractionEnabled = true
        
        phoneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onCallTap(tapGestureRecognizer:))))
        phoneView.image = UIImage(named: "WhiteCard")
        phoneLabel.text = Config.contactNumber
        timeTableLabel.text = Config.timeTable
    }
    
    func setInfectedText() -> NSMutableAttributedString{
        let date = self.since ?? Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let actualizado = formatter.string(from: date)
        
        
        let daysSinceLastInfection = Date().days(sinceDate: since ?? Date()) ?? 0
        let text = "<b>\(daysSinceLastInfection) días</b> (actualizado \(actualizado))".htmlToAttributedString?.formatHtmlString(withBaseFont: "Muli", andSize: 16)
        return text ?? NSMutableAttributedString()
    }
    
    @objc func onCallTap(tapGestureRecognizer: UITapGestureRecognizer) {
        open(phone: Config.contactNumber)
    }
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let url = URL(string: "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/ciudadania.htm") else { return }
        UIApplication.shared.open(url)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}
