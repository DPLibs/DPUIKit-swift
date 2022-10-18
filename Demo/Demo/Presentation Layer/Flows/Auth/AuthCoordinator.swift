//
//  AuthCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class AuthCoordinator: DPNavigationCoordinator {
    
    // MARK: - Init
    init(navigationController: UINavigationController?, authManager: AuthManager) {
        self.authManager = authManager
        
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Props
    private let authManager: AuthManager
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showPhone()
    }
    
    override func finish() {
        self.authManager.login()
        
        super.finish()
    }
    
}

// MARK: - Private
private extension AuthCoordinator {
    
    func showPhone() {
        let vc = AuthPhoneViewController()
        vc.didTapConfirm = { [weak self] in
            self?.showCode()
        }
        vc.coordinator = self
        self.push(vc)
    }
    
    func showCode() {
        let vc = AuthPhoneCodeViewController()
        vc.didTapConfirm = { [weak self] in
            self?.finish()
        }
        self.push(vc)
    }
    
}
