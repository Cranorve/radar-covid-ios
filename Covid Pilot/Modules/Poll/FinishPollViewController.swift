//
//  FinishPollViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 15/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class FinishPollViewController: UIViewController {
    
    @IBOutlet weak var phoneView: BackgroundView!
    
    
    var router: AppRouter?

    @IBAction func onHome(_ sender: Any) {
        router?.route(to: .Home, from: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneView.image = UIImage(named: "WhiteCard")
    }


}
