//
//  PrivacyViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func onContinue(_ sender: Any) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 4
        pageControl.currentPage = 1
        view.bringSubviewToFront(pageControl)

        // Do any additional setup after loading the view.
    }
    

}
