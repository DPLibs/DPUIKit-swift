//
//  MainCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 04.06.2022.
//

import Foundation
import UIKit
import DPUIKit

class MainCoordinator: DPWindowCoordinator {
    
    // MARK: - Init
    init(window: UIWindow?, user: UserModel) {
        self.user = user
        super.init(window: window)
    }
    
    // MARK: - Props
    var user: UserModel
    
    private lazy var tabbarController: MainTabBarController = {
        let itemsTypes: [DPTabBarItem.MainTabBarItemType] = [.news, .profile]
        
        let viewControllers: [UIViewController] = itemsTypes.map { type in
            switch type {
            case .news:
                let nc = DPNavigationController()
                nc.tabBarItem = DPTabBarItem(type: type)
                let coordinator = NewsCoordinator(navigationController: nc)
                coordinator.start()
                return nc
            case .profile:
                let nc = DPNavigationController()
                nc.tabBarItem = DPTabBarItem(type: type)
                let coordinator = UserCoordinator(navigationController: nc, user: self.user)
                coordinator.start()
                return nc
            }
        }
        
        let result = MainTabBarController()
        result.setViewControllers(viewControllers, animated: true)
        result.coordinator = self
        return result
    }()
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.show(self.tabbarController)
    }
    
}
