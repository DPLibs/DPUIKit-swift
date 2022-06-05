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
    init(navigationController: UINavigationController?, user: UserModel) {
        self.user = user
        
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Props
    private var user: UserModel {
        didSet {
            (self.navigationController?.viewControllers ?? []).forEach {
                guard let vc = $0 as? UserEditable else { return }
                vc.setUser(self.user)
            }
        }
    }
    
    private var loginHanlder: LoginHandlder? {
        (UIApplication.shared.delegate as? AppDelegate)?.appCooridinator.authManager
    }
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showProfile()
    }
    
}

// MARK: - Private
private extension UserCoordinator {
    
    func showProfile() {
        let vc = UserProfileViewController(model: .init(user: self.user))
        vc.didTapEdit = { [weak self] _ in
            self?.showEdit()
        }
        vc.didTapExit = { [weak self] in
            self?.loginHanlder?.logout()
        }
        vc.coordinator = self
        self.push(vc)
    }
    
    func showEdit() {
        let coordinator = UserEditCoordinator(navigationController: self.navigationController, user: self.user)
        coordinator.didEditUser = { [weak self] user in
            self?.user = user
            self?.popToRoot()
        }
        coordinator.start()
    }
    
}
