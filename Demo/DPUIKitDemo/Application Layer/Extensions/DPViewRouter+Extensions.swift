//
//  DPViewRouter+Extensions.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit

extension DPViewRouter {
    
    func showInitial() {
        let vc = InitialViewController()
        let navigation = DPNavigationController(rootViewController: vc)
        self.setupRootController(navigation)
    }
    
}
