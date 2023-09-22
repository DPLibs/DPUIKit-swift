//
//  NewsListViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import DPUIKit

class NewsListViewModel: DPViewModel {
    
    // MARK: - Props
    private(set) var news: [News] = []
    
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
                self?.news.removeAll()
            }
            self?.news += .generate(count: 10)
            self?._output?.modelReloaded(self)
            self?._output?.modelFinishLoading(self, withError: nil)
        }
    }
    
}
