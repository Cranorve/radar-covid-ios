//
//  TabBarController.swift
//  Covid Pilot
//
//  Created by alopezh on 09/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import Foundation

import UIKit

class TabBarController: UITabBarController {
    
    var homeViewController: HomeViewController
    
    init(homeViewController: HomeViewController) {
        self.homeViewController = homeViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(named: "iconsPositive"),
            selectedImage: UIImage(named: "iconsPositive"))
        
        setViewControllers([homeViewController], animated: false)
    }
    
}

