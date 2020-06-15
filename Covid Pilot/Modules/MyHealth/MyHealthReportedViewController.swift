//
//  MyHealthReportedViewController.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 10/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class MyHealthReportedViewController: UIViewController {

    var router: AppRouter?
    
    @IBAction func onBack(_ sender: Any) {
        router?.route(to: Routes.Home, from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
