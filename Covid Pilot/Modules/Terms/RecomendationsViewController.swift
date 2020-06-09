//
//  RecomendationsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class RecomendationsViewController: UIViewController {
    
    var router: AppRouter?

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func onFinish(_ sender: Any) {
        router?.route(to: Routes.Home, from: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = 4
        pageControl.currentPage = 3
        view.bringSubviewToFront(pageControl)
    }




}
