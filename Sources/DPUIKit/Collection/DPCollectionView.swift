//
//  DPCollectionView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

/// Custom component [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview).
open class DPCollectionView: UICollectionView, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Props
    
    open override var refreshControl: UIRefreshControl? {
        didSet { self.bringRefreshControlToFront() }
    }
    
    /// Property for storing a strong reference to ``DPCollectionAdapter``.
    open var adapter: DPCollectionAdapter? {
        didSet { self.adapter?.collectionView = self }
    }
    
    // MARK: - Methods
    open func setupComponents() {
        self.backgroundColor = .white
        self.keyboardDismissMode = .onDrag
    }
    
    open func updateComponents() {}
    
    open func bringRefreshControlToFront() {
        guard let refreshControl = self.refreshControl else { return }
        self.bringSubviewToFront(refreshControl)
    }
}
