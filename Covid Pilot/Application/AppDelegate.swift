//
//  AppDelegate.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 04/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var injection: Injection = Injection();

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if JailBreakDetect.isJailbroken() {
            exit(-1)
        }
        if Config.debug {
             NetworkActivityLogger.shared.startLogging()
        }
        
        debugPrint("Current Environment: \(Config.environment)")
        
        let setupUseCase = injection.resolve(SetupUseCase.self)!
        
        do {
            try setupUseCase.initializeSDK()
        } catch {
            debugPrint("Error initializing DP3T \(error)")
        }
        
        let notificationHandler = injection.resolve(NotificationHandler.self)!
        
        notificationHandler.setupNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    static var shared: AppDelegate {
       return UIApplication.shared.delegate as! AppDelegate
    }

}

