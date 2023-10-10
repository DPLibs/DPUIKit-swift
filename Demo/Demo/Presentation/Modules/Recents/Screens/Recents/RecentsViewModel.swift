//
//  RecentsViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import DPUIKit

class RecentsViewModel: DPViewModel {
    
    // MARK: - Init
    override init() {
        self.recentService = RecentMockService()
    }
    
    // MARK: - Props
    private let recentService: RecentService
    private(set) var recents: [Recent] = []
    
    var onRecents: (([Recent]) -> Void)?
    var onCreateRecent: ((Recent) -> Void)?
    var onDeleteRecent: ((Recent) -> Void)?
    
    // MARK: - Methods
    override func reload() {
        super.reload()
        
        self.recentService.getRecents { [weak self] recents in
            self?.recents  = recents
            self?.onRecents?(self?.recents ?? [])
        }
    }
    
    override func loadMore() {
        super.loadMore()
        
        self.recentService.getRecents { [weak self] recents in
            self?.recents += recents
            self?.onRecents?(self?.recents ?? [])
        }
    }
    
    func createRecent() {
        self.recentService.createRecent { [weak self] recent in
            self?.recents.insert(recent, at: 0)
            self?.onCreateRecent?(recent)
        }
    }
    
    func deleteRecent(_ recent: Recent) {
        self.recentService.deleteRecent(recent) { [weak self] in
            self?.recents.removeAll(where: { $0 == recent })
            self?.onDeleteRecent?(recent)
        }
    }
    
}
