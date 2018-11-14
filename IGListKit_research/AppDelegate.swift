//
//  AppDelegate.swift
//  IGListKit_research
//
//  Created by Serg Liamthev on 11/13/18.
//  Copyright © 2018 ANODA. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        let mainVC = DiffTableViewController()
//        let mainVC = ViewController()
        let navVC = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        return true
    }

}

