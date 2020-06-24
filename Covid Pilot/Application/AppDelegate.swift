//
//  AppDelegate.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 04/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import DP3TSDK
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, LoggingDelegate, ActivityDelegate {

    var window: UIWindow?
    
    var injection: Injection = Injection();

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if JailBreakDetect.isJailbroken() {
            exit(-1)
        }
        #if DEBUG
            NetworkActivityLogger.shared.startLogging()
        #endif
        
        initializeSDK()
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
    
    private func initializeSDK() {
        
        let preferencesRepository = injection.resolve(PreferencesRepository.self)!
        
        let url = URL(string: Config.dppptUrl)!
//        DP3TTracing.loggingEnabled = true
        DP3TTracing.loggingDelegate = self
        DP3TTracing.activityDelegate = self
        try! DP3TTracing.initialize(with: .init(appId: "com.indra.covidpilot",
                                                bucketBaseUrl: url,
                                                reportBaseUrl: url,
                                                jwtPublicKey: Config.validationKey,
                                                mode: Config.dp3tMode) )
        
        if (preferencesRepository.isTracingActive()) {
            do {
                try DP3TTracing.startTracing()
            } catch {
                debugPrint("Error starting tracing \(error)")
            }
        } else {
            DP3TTracing.stopTracing()
        }
        
    }
    
    func log(_ string: String, type: OSLogType) {
//        debugPrint(string)
    }
    
    func syncCompleted(totalRequest: Int, errors: [DP3TTracingError]) {
        debugPrint("DP3T Sync totalRequest \(totalRequest)")
        for error in errors {
            debugPrint("DP3T Sync error \(error)")
        }
    }
    
    func fakeRequestCompleted(result: Result<Int, DP3TNetworkingError>) {
        debugPrint("DP3T Fake request completed...")
    }
    
    func outstandingKeyUploadCompleted(result: Result<Int, DP3TNetworkingError>) {
        debugPrint("DP3T OutstandingKeyUpload...")
    }


}

