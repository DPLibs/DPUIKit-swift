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
    
    // MARK: - Props
    private(set) var recents: [Recent] = []
    var didAdd: ((_ recent: Recent, _ index: Int) -> Void)?
    var didDelete: ((Recent) -> Void)?
    
    // MARK: - Methods
    override func reload() {
        self.reload(isReload: true)
    }
    
    override func loadMore() {
        self.reload(isReload: false)
    }
    
    func add() {
        let recent = Recent.moc()
        self.recents.insert(recent, at: 0)
        self.didAdd?(recent, 0)
    }
    
    func deleteRecent(_ recent: Recent) {
        self.recents.removeAll(where: { recent.id == $0.id })
        self.didDelete?(recent)
    }
    
}

// MARK: - Private
private extension RecentsViewModel {
    
    func reload(isReload: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(500)) { [weak self] in
            if isReload {
                self?.recents.removeAll()
            }
            self?.recents += .moc(count: 10)
            self?._output?.modelReloaded(self)
            self?._output?.modelFinishLoading(self, withError: nil)
        }
    }
    
}
