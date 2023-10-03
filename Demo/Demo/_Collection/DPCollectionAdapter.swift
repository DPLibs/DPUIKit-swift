//
//  DPCollectionAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit
import DPUIKit

/// Component for managing a [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview).
open class DPCollectionAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Init
    public override init() {}
    
    // MARK: - Types
    public typealias Closure = () -> Void
    public typealias ItemContext = (cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    public typealias ItemContextClosure = (ItemContext) -> Void
//    public typealias RowContextToSwipeActionsConfiguration = (RowContext) -> UISwipeActionsConfiguration?
//    public typealias RowContextToCGFloat = (RowContext) -> CGFloat?
//    public typealias TitleContextToCGFloat = ((model: DPRepresentableModel, section: Int)) -> CGFloat?
    
    // MARK: - Props
    
    /// Weak reference to ``DPCollectionView``.
    ///
    /// When installed, this adapter is matched to the [UICollectionViewDelegate](https://developer.apple.com/documentation/uikit/uicollectionviewdelegate) and [UICollectionViewDataSource](https://developer.apple.com/documentation/uikit/uicollectionviewdatasource) of the ``DPCollectionView``.
    open weak var collectionView: DPCollectionView? {
        didSet {
            self.collectionView?.dataSource = self
            self.collectionView?.delegate = self
        }
    }
    
    /// An array of sections.
    ///
    /// Used to display `cells` and other `subviews` of a ``collectionView``.
    open var sections: [DPCollectionSectionProtocol] = []
    
    /// Cells adapters.
    open internal(set) var itemAdapters: [String: DPCollectionItemAdapterProtocol] = [:]
    
    /// Registered cell IDs.
    open internal(set) var registeredСellIdentifiers: Set<String> = []
    
    open var onCellForItem: DPCollectionItemContextClosure?
    open var willDisplayItem: DPCollectionItemContextClosure?
    open var didSelectItem: DPCollectionItemContextClosure?
    open var didDeselectItem: DPCollectionItemContextClosure?
    open var onDisplayFirstItem: (() -> Void)?
    open var onDisplayLastItem: (() -> Void)?
    
    // MARK: - Methods
    
    // MARK: - UICollectionViewDataSource
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.sections.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return 0 }
        return self.sections[section].items.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.sections.item(at: indexPath) else { return UICollectionViewCell() }
        let cellIdentifier = String(describing: item.cellClass)
        
        if !self.registeredСellIdentifiers.contains(cellIdentifier) {
            collectionView.register(item.cellClass, forCellWithReuseIdentifier: cellIdentifier)
            self.registeredСellIdentifiers.insert(cellIdentifier)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? DPCollectionItemCellProtocol {
            cell._model = item
            
            let context: DPCollectionItemContext = (cell, item, indexPath)
            self.onCellForItem?(context)
            item.onCell?(context)
        }

        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = self.collectionView?.cellForItem(at: indexPath) as? DPCollectionItemCellProtocol,
            let model = self.sections.item(at: indexPath)
        else { return }
        
        let context: DPCollectionItemContext = (cell, model, indexPath)
        self.didSelectItem?(context)
        model.didSelect?(context)
    }

    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard
            let cell = self.collectionView?.cellForItem(at: indexPath) as? DPCollectionItemCellProtocol,
            let model = self.sections.item(at: indexPath)
        else { return }
        
        let context: DPCollectionItemContext = (cell, model, indexPath)
        self.didDeselectItem?(context)
        model.didDeselect?(context)
    }
    
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DPCollectionItemCellProtocol, let model = self.sections.item(at: indexPath) {
            let context: DPCollectionItemContext = (cell, model, indexPath)
            self.willDisplayItem?(context)
            model.willDisplay?(context)
        }
        
        if indexPath == IndexPath(item: 0, section: 0) {
            self.onDisplayFirstItem?()
        }
        
        if !self.sections.isEmpty, indexPath == IndexPath(item: (self.sections.last?.items.count ?? 0) - 1, section: self.sections.count - 1) {
            self.onDisplayLastItem?()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        self.sections.item(at: indexPath)?.cellSize ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        self.sections.inset(at: section) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }
    
}
