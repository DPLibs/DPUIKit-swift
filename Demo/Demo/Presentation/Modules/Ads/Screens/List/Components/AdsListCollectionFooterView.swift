//
//  AdsListCollectionFooterView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 04.10.2023.
//

import Foundation
import UIKit
import DPUIKit

final class AdsListCollectionFooterView: DPCollectionSupplementaryView {
    
    // MARK: - Props
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    private let titleLabel = UILabel().applyStyles(.font(.systemFont(ofSize: 14, weight: .medium)), .textAlignment(.right))
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.titleLabel.addToSuperview(self, withConstraints: [ .edges(.init(top: 8, leading: 16, bottom: -8, trailing: -16)) ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        guard let model else { return }
        self.titleLabel.text = "Total \(model.total)"
    }
}

// MARK: - Types
extension AdsListCollectionFooterView {
    
    typealias Adapter = DPCollectionSupplementaryAdapter<AdsListCollectionFooterView, Model>
    
    struct Model: DPRepresentableModel {
        let total: Int
    }
    
}
