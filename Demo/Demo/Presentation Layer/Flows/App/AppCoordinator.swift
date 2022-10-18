//
//  AppCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class AppCoordinator: DPWindowCoordinator {
    
    // MARK: - Init
    override init(window: UIWindow? = nil) {
        self.userManager = .init()
        self.authManager = .init()
        
        super.init(window: window)
        
        self.authManager.didLogout = { [weak self] in
            self?.start()
        }
    }
    
    // MARK: - Props
    private let userManager: UserManager
    private let authManager: AuthManager
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showInitial()

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else { return }

            switch (self.authManager.isAutorized, self.userManager.user.isFilled) {
            case (false, false), (false, true):
                self.showAuth()
            case (true, false):
                self.showUserEdit()
            case (true, true):
                self.showMain()
            }
        }
    }
    
}

// MARK: - Private
private extension AppCoordinator {
    
    func showInitial() {
        let vc = InitialViewController()
        self.show(vc)
    }
    
    func showAuth() {
        let nc = DPNavigationController()
        
        let coordinator = AuthCoordinator(navigationController: nc, authManager: self.authManager)
        coordinator.didFinish = { [weak self] _ in
            self?.start()
        }
        coordinator.start()
        
        self.show(nc)
    }
    
    func showUserEdit() {
        let nc = DPNavigationController()
        let coordinator = UserEditCoordinator(navigationController: nc, userManager: self.userManager)
        coordinator.didFinish = { [weak self] _ in
            self?.start()
        }
        coordinator.start()
        self.show(nc)
    }
    
    func showMain() {
        MainCoordinator(
            window: self.window,
            userManager: self.userManager,
            authManager: self.authManager
        ).start()
    }
    
}
