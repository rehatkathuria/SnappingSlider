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

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        if let mainWindow = window {
            
            mainWindow.backgroundColor = UIColor.whiteColor()
            mainWindow.rootViewController = ViewController()
            mainWindow.makeKeyAndVisible()
        }
        return true
    }
    
}

