//
//  HomeViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var router: AppRouter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onCommunicate(_ sender: Any) {
        router?.route(to: Routes.MyHealth, from: self)
    }
    

}
