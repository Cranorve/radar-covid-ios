//
//  RunningViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class RunningViewController: UIViewController {
    
    var nextDelegate: NextDelegate?
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func onContinue(_ sender: Any) {
        nextDelegate?.next()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }

}
