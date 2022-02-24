//
//  AppCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class AppCoordinator {
    
    // MARK: - Init
    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Props
    private weak var window: UIWindow?
    
    private var rootViewController: UIViewController? {
        get { self.window?.rootViewController }
        set {
            self.window?.rootViewController = newValue
            self.window?.makeKeyAndVisible()
        }
    }
    
    private var isAutorized: Bool {
        get { AuthManager.isAutorized }
        set { AuthManager.isAutorized = newValue }
    }
    
    private var user: UserModel {
        get { UserManager.user }
        set { UserManager.user = newValue }
    }
    
    private lazy var authCooridinator: AuthCoordinator = {
        let result = AuthCoordinator()
        result.didAutorized = { [weak self] in
            self?.isAutorized = true
            self?.start()
        }
        
        return result
    }()
    
    // MARK: - Methods
    func start() {
        self.rootViewController = InitialViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else { return }
            
            switch (self.isAutorized, self.user.isFilled) {
            case (false, false), (false, true):
                self.startAuth()
            case (true, false):
                self.startUserEdit()
            case (true, true):
                self.startMain()
            }
        }
    }
    
    private func startAuth() {
        self.rootViewController = self.authCooridinator.start()
    }
    
    private func startUserEdit() {
        let vc = UserEditViewController(model: .init(user: self.user))
        vc.didTapDone = { [weak self] user in
            self?.user = user
            self?.start()
        }
        
        let navigation = DPNavigationController(rootViewController: vc)
        self.rootViewController = navigation
    }
    
    private func startMain() {
        let vc = MainTabBarController(user: self.user)
        vc.didLogout = { [weak self] in
            self?.isAutorized = false
            self?.start()
        }
        vc.didUserEdit = { [weak self] user in
            self?.user = user
        }
        self.rootViewController = vc
    }
    
}
