//
//  DPCollectionItemCell.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

/// Protocol for defining a custom [UICollectionViewCell](https://developer.apple.com/documentation/uikit/uicollectionviewcell).
public protocol DPCollectionItemCellType: UICollectionViewCell {
    
    /// Cell model.
    /// Set to the cell in the ``DPCollectionAdapter/collectionView(_:cellForItemAt:)``.
    /// Can also be set by using certain ``DPCollectionUpdate`` in the ``DPCollectionAdapter/performBatchUpdates(_:completion:)``.
    var _model: Sendable? { get set }
}

/// Basic implementation of the ``DPCollectionItemCellType``.
open class DPCollectionItemCell: UICollectionViewCell, DPCollectionItemCellType, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Props
    open var _model: Sendable? {
        didSet { self.updateComponents() }
    }
    
    // MARK: - Methods
    open func setupComponents() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    open func updateComponents() {}
    
}
