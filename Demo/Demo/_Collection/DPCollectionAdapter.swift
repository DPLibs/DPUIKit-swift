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
    public init(itemAdapters: [DPCollectionItemAdapterProtocol] = []) {
        super.init()
        self.addItemAdapters(itemAdapters)
    }
    
    // MARK: - Types
    public typealias Closure = () -> Void
    public typealias ItemContext = (cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    public typealias ItemContextClosure = (ItemContext) -> Void
    public typealias ItemContextToCGSize = ((model: DPRepresentableModel, indexPath: IndexPath)) -> CGSize?
    public typealias SectionContext = (model: DPCollectionSectionProtocol, index: Int)
    public typealias SectionContextToUIEdgeInsets = (SectionContext) -> UIEdgeInsets?
    public typealias SectionContextToCGFloat = (SectionContext) -> CGFloat?
    
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
    
    /// Called int the ``collectionView(_:cellForItemAt:))``.
    open var onCellForItem: ItemContextClosure?
    
    /// Called int the ``collectionView(_:willDisplay:forItemAt:)``.
    open var willDisplayItem: ItemContextClosure?
    
    /// Called int the ``collectionView(_:didSelectItemAt:)``.
    open var didSelectItem: ItemContextClosure?
    
    /// Called int the ``collectionView(_:didSelectItemAt:)``.
    open var didDeselectItem: ItemContextClosure?
    
    /// Called int the ``collectionView(_:willDisplay:forItemAt:)`` when the first cell is displayed.
    open var onDisplayFirstItem: Closure?
    
    /// Called int the ``collectionView(_:willDisplay:forItemAt:)`` when the last cell is displayed.
    open var onDisplayLastItem: Closure?
    
    /// Called int the ``collectionView(_:layout:sizeForItemAt:)``.
    open var onSizeForItem: ItemContextToCGSize?
    
    /// Called int the ``collectionView(_:layout:insetForSectionAt:)``.
    open var onInsetForSection: SectionContextToUIEdgeInsets?
    
    /// Called int the ``collectionView(_:layout:minimumLineSpacingForSectionAt:)``.
    open var onMinimumLineSpacingForSection: SectionContextToCGFloat?
    
    /// Called int the ``collectionView(_:layout:minimumInteritemSpacingForSectionAt:)``.
    open var onMinimumInteritemSpacingForSection: SectionContextToCGFloat?
    
    // MARK: - Methods
    
    /// Add adapters for cells.
    open func addItemAdapters(_ itemAdapters: [DPCollectionItemAdapterProtocol]) {
        for adapter in itemAdapters {
            self.itemAdapters[adapter.modelRepresentableIdentifier] = adapter
        }
    }
    
    /// Reload data with a new array of sections.
    ///
    /// Install new sections and call `collectionView.reloadData()`.
    ///
    /// - Parameter sections: new array of sections. Will be installed in ``sections``.
    open func reloadData(_ sections: [DPCollectionSectionProtocol]) {
        self.sections = sections
        self.collectionView?.reloadData()
    }
    
    /// Update data using an updates array.
    ///
    /// Call `tableView.performBatchUpdates()` with updates array.
    ///
    /// - Parameter updates: array of ``DPCollectionUpdate``.
    open func performBatchUpdates(_ updates: [DPCollectionUpdate], completion: ((Bool) -> Void)? = nil) {
        self.collectionView?.performBatchUpdates(
            { [weak self] in
                guard let self = self else { return }
                updates.forEach({ $0.perform(self) })
            },
            completion: completion
        )
    }
    
    // MARK: - UICollectionViewDataSource
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        self.sections.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return 0 }
        return self.sections[section].items.count
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let model = self.sections.item(at: indexPath),
            let adapter = self.itemAdapters[model._representableIdentifier]
        else { return UICollectionViewCell() }
        
        let cellClass = adapter.cellClass
        let cellIdentifier = String(describing: cellClass)
        
        if !self.registeredСellIdentifiers.contains(cellIdentifier) {
            collectionView.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
            self.registeredСellIdentifiers.insert(cellIdentifier)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? DPCollectionItemCellProtocol {
            cell._model = model
            
            self.onCellForItem?((cell, model, indexPath))
            adapter.onCell(cell: cell, model: model, indexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DPCollectionItemCellProtocol, let model = self.sections.item(at: indexPath) {
            self.willDisplayItem?((cell, model, indexPath))
            self.itemAdapters[model._representableIdentifier]?.willDisplay(cell: cell, model: model, indexPath: indexPath)
        }

        if indexPath == IndexPath(row: 0, section: 0) {
            self.onDisplayFirstItem?()
        }

        if !self.sections.isEmpty, indexPath == IndexPath(row: (self.sections.last?.items.count ?? 0) - 1, section: self.sections.count - 1) {
            self.onDisplayLastItem?()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? DPCollectionItemCellProtocol,
            let model = self.sections.item(at: indexPath)
        else { return }

        self.didSelectItem?((cell, model, indexPath))
        self.itemAdapters[model._representableIdentifier]?.didSelect(cell: cell, model: model, indexPath: indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? DPCollectionItemCellProtocol,
            let model = self.sections.item(at: indexPath)
        else { return }

        self.didDeselectItem?((cell, model, indexPath))
        self.itemAdapters[model._representableIdentifier]?.didDeselect(cell: cell, model: model, indexPath: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let defaultValue: CGSize = (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
        
        guard let model = self.sections.item(at: indexPath) else { return defaultValue }
        let adapter = self.itemAdapters[model._representableIdentifier]
        
        return adapter?.onSizeForItem(model: model, indexPath: indexPath) ?? self.onSizeForItem?((model, indexPath)) ?? defaultValue
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let defaultValue = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        
        guard let model = self.sections.section(at: section) else { return defaultValue }
        return self.onInsetForSection?((model, section)) ?? defaultValue
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let defaultValue = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? .zero
        
        guard let model = self.sections.section(at: section) else { return defaultValue }
        return self.onMinimumLineSpacingForSection?((model, section)) ?? defaultValue
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let defaultValue = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? .zero
        
        guard let model = self.sections.section(at: section) else { return defaultValue }
        return self.onMinimumInteritemSpacingForSection?((model, section)) ?? defaultValue
    }

//    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//
//    }
//
//    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//
//    }
    
}
