//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import Pageboy

class TermsViewController: PageboyViewController, PageboyViewControllerDataSource, NextDelegate {

    var slides: [UIViewController] = [];
    
    var recomendationsVC: RecomendationsViewController?
    
    var onBoardingCompletedUseCase: OnboardingCompletedUseCase?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()
        
        self.dataSource = self
        self.isScrollEnabled = false
    
    }
    
    
    func createSlides() -> [UIViewController] {
        let runningVC = RunningViewController()
        runningVC.nextDelegate = self
        let privacyVC = PrivacyViewController()
        privacyVC.nextDelegate = self
        let proximityVC = ProximityViewController()
        proximityVC.nextDelegate = self

        return [runningVC, privacyVC, proximityVC, recomendationsVC!]
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        slides.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        slides[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    func next() {
        self.scrollToPage(.next, animated: true)
    }


}

protocol NextDelegate {
    func next()
}
