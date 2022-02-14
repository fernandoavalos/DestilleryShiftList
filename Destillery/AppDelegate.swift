//
//  AppDelegate.swift
//  Destillery
//
//  Created by Fernando Avalos on 10/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else {
            return false
        }
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
        return true
    }
}

