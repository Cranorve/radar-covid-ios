//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var router: AppRouter?

    @IBOutlet weak var stepbullet1: UILabel!
    
    @IBOutlet weak var stepbullet2: UILabel!
    
    @IBOutlet weak var stepbullet3: UILabel!
    @IBAction func onContinue(_ sender: Any) {
        router?.route(to: .OnBoarding, from: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
