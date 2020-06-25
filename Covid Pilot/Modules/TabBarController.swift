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
    var myDataViewController: MyDataViewController
    var helpLineViewController: HelpLineViewController
    var finishPollViewController: FinishPollViewController
    var preferencesRepository: PreferencesRepository?
    
    init(homeViewController: HomeViewController, myDataViewController: MyDataViewController, helpLineViewController: HelpLineViewController, finishPollViewController: FinishPollViewController, preferencesRepository: PreferencesRepository) {
        self.homeViewController = homeViewController
        self.myDataViewController = myDataViewController
        self.helpLineViewController = helpLineViewController
        self.finishPollViewController = finishPollViewController
        self.preferencesRepository = preferencesRepository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.barStyle = .default
        tabBar.layer.cornerRadius = 15
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        homeViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "MenuHomeNormal"),
            selectedImage: UIImage(named: "MenuHomeSelected"))
        
        myDataViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "MenuInfoNormal"),
            selectedImage: UIImage(named: "MenuInfoSelected"))
        
        helpLineViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "MenuHelpNormal"),
            selectedImage: UIImage(named: "MenuHelpSelected"))
        
        finishPollViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "MenuHelpNormal"),
            selectedImage: UIImage(named: "MenuHelpSelected"))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if preferencesRepository?.isPollCompleted() ?? false {
            setViewControllers([homeViewController, myDataViewController, finishPollViewController], animated: false)
        } else {
            setViewControllers([homeViewController, myDataViewController, helpLineViewController], animated: false)
             
        }
    }
    
    func changeHelplineToFinishPollViewController(){
        
        finishPollViewController.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(named: "MenuHelpNormal"),
            selectedImage: UIImage(named: "MenuHelpSelected"))
        
        setViewControllers([homeViewController, myDataViewController, finishPollViewController], animated: false)
    }
    
}

