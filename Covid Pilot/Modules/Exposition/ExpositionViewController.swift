//
//  ExpositionViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class ExpositionViewController: UIViewController {

    private let bgImageGreen = UIImage(named: "GradientBackgroundGreen")
    
    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var expositionBGView : BackgroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        expositionBGView.image = bgImageGreen
        
        moreInfoView.isUserInteractionEnabled = true
        moreInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
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
