//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import Pageboy

class InfoViewController: PageboyViewController, PageboyViewControllerDataSource, PageboyViewControllerDelegate {

    var slides: [UIViewController] = [];
    
    var proximityVC: ProximityViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()

        self.isScrollEnabled = false
        
        self.delegate = self
        self.dataSource = self    
    }
    
    func createSlides() -> [UIViewController] {
        return [proximityVC!]
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        slides.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        slides[index]
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {

    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, willScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollTo position: CGPoint, direction: PageboyViewController.NavigationDirection, animated: Bool) {
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didReloadWith currentViewController: UIViewController, currentPageIndex: PageboyViewController.PageIndex) {
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }

}
