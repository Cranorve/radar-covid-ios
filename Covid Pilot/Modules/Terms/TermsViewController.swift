//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import Pageboy

class TermsViewController: PageboyViewController, PageboyViewControllerDataSource, PageboyViewControllerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!

    var slides: [UIViewController] = [];
    
    var recomendationsVC: RecomendationsViewController?
    var proximityVC: ProximityViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = createSlides()
        
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        
        self.delegate = self
        self.dataSource = self    
    }
    
    func createSlides() -> [UIViewController] {
        let runningVC = RunningViewController()
        let privacyVC = PrivacyViewController()
        return [runningVC, privacyVC, proximityVC!, recomendationsVC!]
    }
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        slides.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        slides[index]
    }
    
    func pageboyViewController(_ pageboyViewController: PageboyViewController, didScrollToPageAt index: Int, direction: NavigationDirection,animated: Bool) {
        pageControl.currentPage = index
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
