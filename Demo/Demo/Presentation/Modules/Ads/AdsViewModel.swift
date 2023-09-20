//
//  AdsViewModel.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

final class AdsViewModel: DPViewModel {
    
    // MARK: - Props
    private(set) var ads: [Ads] = []
    
    // MARK: - Methods
    override func reload() {
        self._reload(isReload: true)
    }
    
    override func loadMore() {
        self._reload(isReload: false)
    }
    
    private func _reload(isReload: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500)) { [weak self] in
            if isReload {
                self?.ads.removeAll()
            }
            self?.ads += .moc(count: 10)
            self?._output?.modelReloaded(self)
        }
    }
    
}
