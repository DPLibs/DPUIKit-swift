//
//  UserCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 05.06.2022.
//

import Foundation
import UIKit
import DPUIKit

class UserCoordinator: DPNavigationCoordinator {
    
    // MARK: - Init
    init(navigationController: UINavigationController?, userManager: UserManager, authManager: AuthManager) {
        self.userManager = userManager
        self.authManager = authManager
        
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Props
    private let userManager: UserManager
    private let authManager: AuthManager
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showProfile()
    }
    
}

// MARK: - Private
private extension UserCoordinator {
    
    func showProfile() {
        let vc = UserProfileViewController(user: self.userManager.user)
        vc.coordinator = self
        
        vc.didTapEdit = { [weak self] in
            self?.showEdit()
        }
        
        vc.didTapExit = { [weak self] in
            self?.authManager.logout()
        }
        
        self.push(vc)
    }
    
    func showEdit() {
        let coordiantor = UserEditCoordinator(
            navigationController: self.navigationController,
            userManager: self.userManager
        )
        
        coordiantor.didFinish = { [weak self] _ in
            self?.pop()
        }
        
        coordiantor.start()
    }
    
}
