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
    init(window: UIWindow?, userManager: UserManager, authManager: AuthManager) {
        self.userManager = userManager
        self.authManager = authManager
        
        super.init(window: window)
    }
    
    // MARK: - Props
    // MARK: - Props
    private let userManager: UserManager
    private let authManager: AuthManager
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showTabBarController()
    }
    
}

// MARK: - Private
private extension MainCoordinator {
    
    func showTabBarController() {
        let itemsTypes: [DPTabBarItem.MainTabBarItemType] = [.recents, .profile]
        
        let viewControllers: [UIViewController] = itemsTypes.map { type in
            switch type {
            case .recents:
                let nc = DPNavigationController()
                nc.tabBarItem = DPTabBarItem(type: type)
                RecentsCoordinator(navigationController: nc).start()
                return nc
            case .profile:
                let nc = DPNavigationController()
                nc.tabBarItem = DPTabBarItem(type: type)
                UserCoordinator(navigationController: nc, userManager: self.userManager, authManager: self.authManager).start()
                return nc
            }
        }
        
        let vc = MainTabBarController()
        vc.setViewControllers(viewControllers, animated: true)
        vc.coordinator = self
        
        self.show(vc)
    }
    
}
