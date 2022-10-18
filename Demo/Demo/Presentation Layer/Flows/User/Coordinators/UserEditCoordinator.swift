//
//  UserEditCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 03.06.2022.
//

import Foundation
import UIKit
import DPUIKit

class UserEditCoordinator: DPNavigationCoordinator {
    
    // MARK: - Init
    init(navigationController: UINavigationController?, userManager: UserManager) {
        self.userManager = userManager
        
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Props
    private let userManager: UserManager
    
    private var user: UserModel {
        get { self.userManager.user }
        set {
            self.userManager.user = newValue
            
            (self.navigationController?.viewControllers ?? []).forEach {
                guard let vc = $0 as? UserEditable else { return }
                vc.setUser(newValue)
            }
        }
    }
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showUserEdit()
    }
    
}

// MARK: - Private
private extension UserEditCoordinator {
    
    func showUserEdit() {
        let vc = UserEditViewController(model: .init(user: self.user))
        vc.coordinator = self
        
        vc.didTapDone = { [weak self] user in
            self?.user = user
            self?.finish()
        }
        
        self.push(vc)
    }
    
}
