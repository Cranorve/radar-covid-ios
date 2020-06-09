//
//  ProximityViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class ProximityViewController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    
    var nextDelegate: NextDelegate?

    @IBAction func onContinue(_ sender: Any) {
        nextDelegate?.next()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 2
        view.bringSubviewToFront(pageControl)
    }



}
