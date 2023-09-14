//
//  NewsCoordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 05.06.2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class NewsCoordinator: DPNavigationCoordinator {
    
    // MARK: - Methods
    override func start() {
        super.start()
        
        self.showList()
    }
    
}

// MARK: - Private
private extension NewsCoordinator {
    
    func showList() {
        let vc = NewsListViewController()
        vc.didSelect = { [weak self] news in
            self?.showDetail(news)
        }
        vc.coordinator = self
        self.show(vc)
    }
    
    func showDetail(_ news: NewsModel) {
        let vc = NewsDetailViewController(model: .init(news: news))
        self.push(vc)
    }
    
}
