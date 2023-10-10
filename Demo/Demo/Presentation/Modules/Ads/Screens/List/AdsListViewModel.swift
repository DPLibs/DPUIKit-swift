//
//  AdsListViewModel.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

final class AdsListViewModel: DPViewModel {
    
    // MARK: - Props
    private(set) var sections: [Section] = []
    var onDeleteAds: ((_ ads: Ads, _ section: Section) -> Void)?
    var onDeleteSection: ((Section) -> Void)?
    
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
            
            let ads: [Ads] = .moc(count: .random(in: 2...4))
            
            self.sections += [
                .init(name: "Section \(self.sections.count + 1)", ads: ads, total: ads.count)
            ]
            
            self._output?.modelReloaded(self)
        }
    }
    
    func deleteAds(_ ads: Ads) {
        loop: for (sectionOffset, _) in self.sections.enumerated() {
            for (itemOffset, item) in self.sections[sectionOffset].items.enumerated() {
                guard let item = item as? Ads, item.id == ads.id else { continue }
                self.sections[sectionOffset].items.remove(at: itemOffset)
                
                self.sections[sectionOffset].footer = AdsListCollectionFooterView.Model(
                    total: self.sections[sectionOffset].items.count
                )
                
                if self.sections[sectionOffset].items.isEmpty {
                    let section = self.sections[sectionOffset]
                    self.sections.remove(at: sectionOffset)
                    self.onDeleteSection?(section)
                } else {
                    self.onDeleteAds?(ads, self.sections[sectionOffset])
                }
                
                break loop
            }
        }
    }
    
}

// MARK: - Section
extension AdsListViewModel {
    
    struct Section: DPCollectionSectionType, Identifiable {
        
        // MARK: - Init
        init(name: String, ads: [Ads], total: Int) {
            self.items = ads
            self.header = AdsListCollectionHeaderView.Model(title: name)
            self.footer = AdsListCollectionFooterView.Model(total: total)
        }
        
        // MARK: - Props
        let id = UUID()
        var items: [Sendable]
        var header: Sendable?
        var footer: Sendable?
    }
    
}
