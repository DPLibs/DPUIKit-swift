//
//  AppDelegate.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 02.12.2021.
//

import UIKit
import DPUIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    lazy var appCooridinator: AppCoordinator = .init(window: self.window)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = .init()
//        self.window?.rootViewController = DPNavigationController(rootViewController: InitialViewController())
//        self.window?.makeKeyAndVisible()
        self.appCooridinator.start()
        
        return true
    }

}

