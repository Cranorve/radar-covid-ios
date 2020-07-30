//
//  MyHealthReportedViewController.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class MyHealthReportedViewController: BaseViewController {

    var router: AppRouter?
    
    @IBOutlet weak var moreInfoView: UIView!
    
    @IBAction func onBack(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moreInfoView.isUserInteractionEnabled = true
        moreInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
    }
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
        guard let url = URL(string: "https://www.mscbs.gob.es/profesionales/saludPublica/ccayes/alertasActual/nCov-China/ciudadania.htm") else { return }
        UIApplication.shared.open(url)
    }


}
