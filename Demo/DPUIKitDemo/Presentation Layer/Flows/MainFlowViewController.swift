//
//  MainFlowViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit

class MainFlowViewController: DPFlowViewController {
    
    lazy var flowTabBarController: MainTabBarController = .init()
    
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
        self.rootViewController = self.flowTabBarController
    }
    
}


