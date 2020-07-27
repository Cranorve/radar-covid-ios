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
    var preferencesRepository: PreferencesRepository?
    
    init(homeViewController: HomeViewController, myDataViewController: MyDataViewController, helpLineViewController: HelpLineViewController,  preferencesRepository: PreferencesRepository) {
        self.homeViewController = homeViewController
        self.myDataViewController = myDataViewController
        self.helpLineViewController = helpLineViewController
        self.preferencesRepository = preferencesRepository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // The tabBar top border is done using the `shadowImage` and `backgroundImage` properties.
    // We need to override those properties to set the custom top border.
    // Setting the `backgroundImage` to an empty image to remove the default border. tabBar.backgroundImage = UIImage()
    // The `shadowImage` property is the one that we will use to set the custom top border.
    // We will create the `UIImage` of 1x5 points size filled with the red color and assign it to the `shadowImage` property.
    // This image then will get repeated and create the red top border of 5 points width.
    // A helper function that creates an image of the given size filled with the given color.
    // http://stackoverflow.com/a/39604716/1300959
    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
        
    }
    // Setting the `shadowImage` property to the `UIImage` 1x5 red.

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.layer.masksToBounds = true
        tabBar.isTranslucent = true
        tabBar.barStyle = .default
        tabBar.layer.cornerRadius = 15
     
//        tabBar.layer.backgroundColor = UIColor.white.cgColor
        let apareance = UITabBarAppearance()
        apareance.backgroundImage = UIImage.init(named: "tabBarBG")
//        let tabBarBGimage = UIImageView.init(frame: self.tabBar.layer.frame)
//        tabBarBGimage.contentMode = .scaleAspectFill
//        tabBarBGimage.image = UIImage.init(named: "tabBarBG")
//        self.tabBar.insertSubview(tabBarBGimage, at: 0)
//        tabBar.frame.size.height = 200
//        tabBar.frame.origin.y = view.frame.height - 200
        tabBar.clipsToBounds = true
        
        tabBar.standardAppearance = apareance
        
//        tabBar.layer.backgroundColor = UIColor.white.cgColor
//        let image = getImageWithColor(color: UIColor.black, size: CGSize(width: 1.0, height: 5.0))
//        tabBar.shadowImage = image

        
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            setViewControllers([homeViewController, myDataViewController, helpLineViewController], animated: false)
             
    }
    
}

