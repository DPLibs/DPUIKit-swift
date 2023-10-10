//
//  RecentsCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 05.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class RecentsCoordinator: DPNavigationCoordinator {
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showList()
    }
    
}

// MARK: - Private
private extension RecentsCoordinator {
    
    func showList() {
        let vc = RecentsViewController()
        vc.didSelect = { [weak self] recent in
            self?.showDetail(recent)
        }
        vc.coordinator = self
        self.show(vc)
    }
    
    func showDetail(_ recent: Recent) {
        let vc = RecentViewController(model: .init(recent: recent))
        self.push(vc)
    }
    
}
