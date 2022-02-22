//
//  AuthFlowViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit

class AuthFlowViewController: DPFlowViewController {
    
    // MARK: - Props
    private lazy var flowNavigationController: DPNavigationController = .init()
    var didAutorized: Closure?
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
        self.rootViewController = self.flowNavigationController
        self.beginFlow()
    }
    
    override func beginFlow() {
        let vc = AuthPhoneViewController()
        vc.didTapConfirm = { [weak self] in
            self?.showPhoneCode()
        }
        
        self.flowNavigationController.pushViewController(vc, animated: false)
    }
    
    func showPhoneCode() {
        let vc = AuthPhoneCodeViewController()
        vc.didTapConfirm = { [weak self] in
            self?.finishFlow()
        }
        self.flowNavigationController.pushViewController(vc, animated: true)
    }
    
    override func finishFlow() {
        self.didAutorized?()
        
        super.finishFlow()
    }
    
}
