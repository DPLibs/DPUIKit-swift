//
//  AuthCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class AuthCoordinator {
    
    // MARK: - Init
    init(navigationController: DPNavigationController? = nil) {
        self.navigationController = navigationController
    }
    
    // MARK: - Props
    private weak var navigationController: DPNavigationController?
    var didAutorized: Closure?
    
    // MARK: - Methods
    
    @discardableResult
    func start() -> UIViewController {
        let vc = AuthPhoneViewController()
        vc.didTapConfirm = { [weak self] in
            self?.startPhoneCode()
        }
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(vc, animated: false)
            return navigationController
        } else {
            let navigationController = DPNavigationController(rootViewController: vc)
            self.navigationController = navigationController
            return navigationController
        }
    }
    
    private func startPhoneCode() {
        let vc = AuthPhoneCodeViewController()
        vc.didTapConfirm = { [weak self] in
            self?.didAutorized?()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
