//
//  AppDelegate.swift
//  Snapping Slider Example
//
//  Created by Rehat Kathuria on 21/04/2015.
//  Copyright (c) 2015 Kathuria Ltd. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        if let mainWindow = window {
            
            mainWindow.backgroundColor = UIColor.white
            mainWindow.rootViewController = ViewController()
            mainWindow.makeKeyAndVisible()
        }
        return true
    }
    
}

