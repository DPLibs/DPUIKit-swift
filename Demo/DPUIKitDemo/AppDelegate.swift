//
//  AppDelegate.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 02.12.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = .init()
        self.window?.rootViewController = DemoPageContainerViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

