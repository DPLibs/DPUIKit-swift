//
//  DPCollectionSupplementaryView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 04.10.2023.
//

import Foundation
import UIKit

/// Protocol for defining a custom [UICollectionReusableView](https://developer.apple.com/documentation/uikit/uicollectionreusableview).
public protocol DPCollectionSupplementaryViewType: UICollectionReusableView {
    
    /// View model.
    /// Set to view in the ``DPCollectionAdapter/collectionView(_:viewForSupplementaryElementOfKind:at:)``.
    /// Can also be set by using certain ``DPCollectionAdapter`` in the ``DPCollectionAdapter/performBatchUpdates(_:completion:)``.
    var _model: Sendable? { get set }
}

/// Basic implementation of the ``DPCollectionSupplementaryViewType``.
open class DPCollectionSupplementaryView: UICollectionReusableView, DPViewProtocol, DPCollectionSupplementaryViewType {
    
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
    public var _model: Sendable? {
        didSet { self.updateComponents() }
    }
    
    // MARK: - Methods
    open func setupComponents() {}
    
    open func updateComponents() {}
}
