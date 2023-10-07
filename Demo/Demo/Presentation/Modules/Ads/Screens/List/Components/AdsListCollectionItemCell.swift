//
//  AdsListCollectionItemCell.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit
import DPUIKit

final class AdsListCollectionItemCell: DPCollectionItemCell {
    
    // MARK: - Props
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    private let titleLabel = UILabel().applyStyles(.numberOfLines(0))
    private let bodyLabel = UILabel().applyStyles(.numberOfLines(0))
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.contentView.backgroundColor = .lightGray
        
        self.titleLabel.addToSuperview(self.contentView, withConstraints: [
            .top(),
            .leading(),
            .trailing()
        ])
        
        self.bodyLabel.addToSuperview(self.contentView, withConstraints: [
            .bottom(),
            .leading(),
            .trailing(),
            .top(8, to: .anchor(self.titleLabel.bottomAnchor))
        ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.titleLabel.text = self.model?.title
        self.bodyLabel.text = self.model?.body
    }
    
}

// MARK: - Types
extension AdsListCollectionItemCell {
    typealias Model = Ads
    typealias Adapter = DPCollectionItemAdapter<AdsListCollectionItemCell, Model>
}
