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
    private(set) var sections: [Section] = []
    
    // MARK: - Methods
    override func reload() {
        self._reload(isReload: true)
    }
    
    override func loadMore() {
        self._reload(isReload: false)
    }
    
    private func _reload(isReload: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500)) { [weak self] in
            guard let self else { return }
            
            if isReload {
                self.sections.removeAll()
            }
            
            let ads: [Ads] = .moc(count: .random(in: 10...20))
            
            self.sections += [
                .init(name: "Section \(self.sections.count + 1)", ads: ads, total: ads.count)
            ]
            
            self._output?.modelReloaded(self)
        }
    }
    
}

extension AdsViewModel {
    
    struct Section {
        let name: String
        var ads: [Ads]
        let total: Int
    }
    
}
