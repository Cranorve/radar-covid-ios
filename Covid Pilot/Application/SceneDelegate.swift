//
//  SceneDelegate.swift
//  Covid Pilot
//
//  Created by Lino Bustamante on 04/06/2020.
//  Copyright © 2020 Indra. All rights reserved.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let disposeBag = DisposeBag()

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let router = AppDelegate.shared.injection.resolve(AppRouter.self)!
        let configUseCase =  AppDelegate.shared.injection.resolve(ConfigurationUseCase.self)!
        
        configUseCase.getConfig().subscribe(
            onNext:{ settings in
                debugPrint("Configuration  finished")
                let minversion = settings.parameters?.applicationVersion?.ios?.version
                let currentversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
                let minfloat = Float(String((minversion?.prefix(3))!))
                let currentfloat = Float(String((currentversion?.prefix(3))!))
                let minint = Int(String((minversion?.suffix(1))!))
                let currentint = Int(String((currentversion?.suffix(1))!))
                if ((currentfloat?.isLess(than: minfloat ?? 0)) ?? false || ((currentfloat?.isEqual(to: minfloat ?? 0)) ?? false && (currentint ?? 0) < (minint ?? 0))){
                        let alert = Alert.showAlertOk(title: "Error", message: "La versión actual de la aplicación debe ser actualizada a la versión " + String(minfloat!) + "." + String(minint!), buttonTitle: "Aceptar") { (action) in
                            exit(0);

                        }
                        self.window?.rootViewController?.present(alert, animated: true)
                }
            }, onError: {  [weak self] error in
                debugPrint("Configuration errro \(error)")
                self?.window?.rootViewController?.present(Alert.showAlertOk(title: "Error", message: "Se ha producido un error. Compruebe la conexión", buttonTitle: "Aceptar"), animated: true)
        }).disposed(by: disposeBag)
        
        router.route(to: Routes.Welcome, from: navigationController)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

