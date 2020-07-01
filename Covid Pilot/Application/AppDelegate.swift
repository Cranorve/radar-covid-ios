//
//  AppDelegate.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 04/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import BackgroundTasks

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let backgroundTaskIdentifier = "es.gov.radarcovid.syncBgTask"

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
        
        setupUseCase.initializeSDK()
        
        registerBgTask()
        scheduleBackgroundTaskIfNeeded()
        
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
    
    func registerBgTask() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: AppDelegate.backgroundTaskIdentifier, using: .main) { task in
    
            debugPrint("Running task...")
            
            // Handle running out of time
            task.expirationHandler = {
                debugPrint("Task Running out of time")
            }
            
            // Schedule the next background task
            self.scheduleBackgroundTaskIfNeeded()
        }
    }
    
    private func scheduleBackgroundTaskIfNeeded() {

        let taskRequest = BGProcessingTaskRequest(identifier: AppDelegate.backgroundTaskIdentifier)
        taskRequest.requiresNetworkConnectivity = true
        taskRequest.earliestBeginDate = Date(timeIntervalSinceNow: 1)
        do {
            try BGTaskScheduler.shared.submit(taskRequest)
        } catch {
            print("Unable to schedule background task: \(error)")
        }
    }
    
    static var shared: AppDelegate {
       return UIApplication.shared.delegate as! AppDelegate
    }

}

