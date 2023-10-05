//
//  AdsListCollectionHeaderView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 04.10.2023.
//

import Foundation
import UIKit
import DPUIKit

final class AdsListCollectionHeaderView: DPCollectionSupplementaryView {
    
    // MARK: - Props
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    private let titleLabel = UILabel().applyStyles(.font(.systemFont(ofSize: 20, weight: .medium)))
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.titleLabel.addToSuperview(self, withConstraints: [ .edges(.init(top: 8, leading: 16, bottom: -8, trailing: -16)) ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.titleLabel.text = self.model?.title
    }
}

// MARK: - Types
extension AdsListCollectionHeaderView {
    
    typealias Adapter = DPCollectionSupplementaryAdapter<AdsListCollectionHeaderView, Model>
    
    struct Model: DPRepresentableModel {
        let title: String
    }
    
}
