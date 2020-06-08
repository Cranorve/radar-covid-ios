//
//  TermsViewController.swift
//  Covid Pilot
//
//  Created by alopezh on 08/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit

class TermsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides:[UIView] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self

        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
    
    func setupSlideScrollView(slides : [UIView]) {
          scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
          scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
          scrollView.isPagingEnabled = true
          
          for i in 0 ..< slides.count {
              slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
              scrollView.addSubview(slides[i])
          }
      }
    
    func createSlides() -> [UIView] {
        [Bundle.main.loadNibNamed("Running", owner: self, options: nil)?.first as! UIView,
         Bundle.main.loadNibNamed("Privacy", owner: self, options: nil)?.first as! UIView]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex) 
            
            
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
