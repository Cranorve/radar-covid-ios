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
    
    @IBOutlet weak var moreInfoView: UIView!
    @IBOutlet weak var expositionBGView : BackgroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        expositionBGView.image = bgImageRed
        
        moreInfoView.isUserInteractionEnabled = true
        moreInfoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(userDidTapLabel(tapGestureRecognizer:))))
    }
    
    @objc func userDidTapLabel(tapGestureRecognizer: UITapGestureRecognizer) {
           // TODO queda por definir que pasa cuando se pincha en mas informacion
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
