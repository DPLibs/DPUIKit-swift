//
//  AdsCoordinator.swift
//  Demo
//
//  Created by Дмитрий Поляков on 05.10.2023.
//

import Foundation
import UIKit
import DPUIKit

class AdsCoordinator: DPNavigationCoordinator {
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showList()
    }
    
}

// MARK: - Private
private extension AdsCoordinator {
    
    func showList() {
        let vc = AdsListViewController()
        vc.coordinator = self
        self.show(vc)
    }
    
}
