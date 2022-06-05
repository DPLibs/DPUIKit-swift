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
    init(navigationController: UINavigationController?, loginHandlder: LoginHandlder?) {
        self.loginHandlder = loginHandlder
        
        super.init(navigationController: navigationController)
    }
    
    // MARK: - Props
    weak var loginHandlder: LoginHandlder?
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showPhone()
    }
    
    override func finish() {
        self.loginHandlder?.login()
        
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

//class AuthCoordinator {
//
//    // MARK: - Init
//    init(navigationController: DPNavigationController? = nil) {
//        self.navigationController = navigationController
//    }
//
//    // MARK: - Props
//    private weak var navigationController: DPNavigationController?
//    var didAutorized: Closure?
//
//    // MARK: - Methods
//
//    @discardableResult
//    func start() -> UIViewController {
//        let vc = AuthPhoneViewController()

//
//        if let navigationController = self.navigationController {
//            navigationController.pushViewController(vc, animated: false)
//            return navigationController
//        } else {
//            let navigationController = DPNavigationController(rootViewController: vc)
//            self.navigationController = navigationController
//            return navigationController
//        }
//    }
//
//    private func startPhoneCode() {
//        let vc = AuthPhoneCodeViewController()
//        vc.didTapConfirm = { [weak self] in
//            self?.didAutorized?()
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//}
