//
//  FinishPollViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 15/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class FinishPollViewController: UIViewController {

    @IBAction func onHome(_ sender: Any) {
        router?.route(to: .Home, from: self)
    }
    
    var router: AppRouter?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


}
