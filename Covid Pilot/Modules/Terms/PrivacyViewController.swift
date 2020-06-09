//
//  PrivacyViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {
    
    var nextDelegate: NextDelegate?

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func onContinue(_ sender: Any) {
        nextDelegate?.next()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = 4
        pageControl.currentPage = 1
        view.bringSubviewToFront(pageControl)

        // Do any additional setup after loading the view.
    }
    

}
