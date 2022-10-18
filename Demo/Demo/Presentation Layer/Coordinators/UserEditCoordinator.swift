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
    init(navigationController: UINavigationController?, user: UserModel?) {
        self.user = user
        
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Props
    var user: UserModel?
    var didEditUser: ((UserModel) -> Void)?
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showUserEdit()
    }
    
    override func finish() {
        if let user = self.user {
            self.didEditUser?(user)
        }
        
        super.finish()
    }
    
}

// MARK: - Private
private extension UserEditCoordinator {
    
    func showUserEdit() {
        let vc = UserEditViewController(model: .init(user: self.user))
        vc.didTapDone = { [weak self] user in
            self?.user = user
            self?.finish()
        }
        vc.coordinator = self
        self.push(vc)
    }
    
}
