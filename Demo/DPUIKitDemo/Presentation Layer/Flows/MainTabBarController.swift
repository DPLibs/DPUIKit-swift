//
//  MainTabBarController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class MainTabBarController: DPTabBarController {
    
    override func setupComponents() {
        super.setupComponents()
        
        let controllers = DPTabBarItem.TabBarItemType.allCases.map({ type -> (viewController: UIViewController, item: DPTabBarItem) in
            var rootViewController: UIViewController {
                switch type {
                case .news:
                    return NewsListViewController.default()
                case .users:
                    return .init()
                case .profile:
                    return .init()
                }
            }
            
            let item = DPTabBarItem(type: type)
            let viewController = DPNavigationController(rootViewController: rootViewController)
            viewController.tabBarItem = item
            
            return (viewController, item)
        })
        
        self.viewControllers = controllers.map({ $0.viewController })
        self.items = controllers.map({ $0.item })
    }
    
}


// MARK: - DPTabBarItem + TabBarItemType
extension DPTabBarItem {
    
    enum TabBarItemType: Int, CaseIterable {
        case news = 0
        case users = 1
        case profile = 2
    }
    
    convenience init(type: TabBarItemType) {
        switch type {
        case .news:
            self.init(title: "News", image: nil, tag: type.rawValue)
        case .users:
            self.init(title: "Users", image: nil, tag: type.rawValue)
        case .profile:
            self.init(title: "Profile", image: nil, tag: type.rawValue)
        }
    }
    
}
