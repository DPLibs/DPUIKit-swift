//
//  MainFlowViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit

class MainFlowViewController: DPFlowViewController {
    
    // MARK: - Init
    init(user: UserModel) {
        self.user = user
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var user: UserModel
    lazy var flowTabBarController: MainTabBarController = .init(user: self.user)
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
        self.rootViewController = self.flowTabBarController
    }
    
}


