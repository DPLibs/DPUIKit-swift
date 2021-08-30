//
//  MainTabBatController.swift
//  DPUIKit_Example
//
//  Created by Дмитрий Поляков on 29.08.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import DPUIKit

protocol MainTabBarControllerInput: DPTabBarControllerInput {}

class MainTabBarController: DPTabBarController {
    
    override func setupComponets() {
        self.items = [.main]
        
        self.viewControllers = self.items.map({ item in
            var viewController: UIViewController {
                switch item {
                case .main:
                    return MainViewController(model: .init(), router: .init(), errorHanlder: .init())
                default:
                    return .init()
                }
            }
            
            let navigationController = MainNavigationController(rootViewController: viewController)
            navigationController.tabBarItem = item
            
            return navigationController
        })
    }
    
}

extension DPTabBarItem {
    
    static let main: DPTabBarItem = .init(title: "Main", image: nil, tag: 0)
    
}
