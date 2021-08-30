//
//  AppDelegate.swift
//  DPUIKit
//
//  Created by Dmitriy Polyakov on 08/29/2021.
//  Copyright (c) 2021 Dmitriy Polyakov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = .init()
        self.window?.rootViewController = MainTabBarController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

