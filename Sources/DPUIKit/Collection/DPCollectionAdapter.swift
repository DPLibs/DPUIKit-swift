//
//  DPCollectionAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

/// Component for managing a [UICollectionView](https://developer.apple.com/documentation/uikit/uicollectionview).
open class DPCollectionAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Init
    public init(
        itemAdapters: [DPCollectionItemAdapterType] = [],
        supplementaryAdapters: [DPCollectionSupplementaryAdapterType] = []
    ) {
        super.init()
        self.addItemAdapters(itemAdapters)
        self.addSupplementaryAdapters(supplementaryAdapters)
    }
    
    // MARK: - Types
    public typealias Closure = () -> Void
    public typealias ItemContext = (cell: DPCollectionItemCellType, model: DPAnyRepresentable, indexPath: IndexPath)
    public typealias ItemContextClosure = (ItemContext) -> Void
    public typealias ItemContextToCGSize = ((model: DPAnyRepresentable, indexPath: IndexPath)) -> CGSize?
    
    public typealias SectionContext = (model: DPRepresentableSectionType, index: Int)
    public typealias SectionContextToUIEdgeInsets = (SectionContext) -> UIEdgeInsets?
    public typealias SectionContextToCGFloat = (SectionContext) -> CGFloat?
    
    public typealias SupplementaryContextToCGSize = ((model: DPAnyRepresentable, section: Int)) -> CGSize?
    
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
    open var sections: [DPRepresentableSectionType] = []
    
    /// Cells adapters.
    open internal(set) var itemAdapters: [ObjectIdentifier: DPCollectionItemAdapterType] = [:]
    
    /// Supplementary views adapters.
    open internal(set) var supplementaryAdapters: [ObjectIdentifier: DPCollectionSupplementaryAdapterType] = [:]
    
    /// Registered cell IDs.
    open internal(set) var registeredСellReuseIdentifiers: Set<String> = []
    
    /// Registered supplementary views IDs.
    open internal(set) var registeredSupplementaryViewsReuseIdentifiers: Set<String> = []
    
    /// Called in the ``collectionView(_:cellForItemAt:)``.
    open var onCellForItem: ItemContextClosure?
    
    /// Called in the ``collectionView(_:willDisplay:forItemAt:)``.
    open var willDisplayItem: ItemContextClosure?
    
    /// Called in the ``collectionView(_:didSelectItemAt:)``.
    open var didSelectItem: ItemContextClosure?
    
    /// Called in the ``collectionView(_:didSelectItemAt:)``.
    open var didDeselectItem: ItemContextClosure?
    
    /// Called in the ``collectionView(_:willDisplay:forItemAt:)`` when the first cell is displayed.
    open var onDisplayFirstItem: Closure?
    
    /// Called in the ``collectionView(_:willDisplay:forItemAt:)`` when the last cell is displayed.
    open var onDisplayLastItem: Closure?
    
    /// Called in ``collectionView(_:layout:sizeForItemAt:)``.
    open var onSizeForItem: ItemContextToCGSize?
    
    /// Called in ``collectionView(_:layout:insetForSectionAt:)``.
    open var onInsetForSection: SectionContextToUIEdgeInsets?
    
    /// Called in ``collectionView(_:layout:minimumLineSpacingForSectionAt:)``.
    open var onMinimumLineSpacingForSection: SectionContextToCGFloat?
    
    /// Called in ``collectionView(_:layout:minimumInteritemSpacingForSectionAt:)``.
    open var onMinimumInteritemSpacingForSection: SectionContextToCGFloat?
    
    /// Called in ``collectionView(_:layout:referenceSizeForHeaderInSection:)``.
    open var onReferenceSizeForHeaderInSection: SupplementaryContextToCGSize?
    
    /// Called in ``collectionView(_:layout:referenceSizeForFooterInSection:)``.
    open var onReferenceSizeForFooterInSection: SupplementaryContextToCGSize?
    
    // MARK: - Methods
    
    /// Add adapters for cells.
    open func addItemAdapters(_ adapters: [DPCollectionItemAdapterType]) {
        for adapter in adapters {
            self.itemAdapters[adapter.modelReuseID] = adapter
        }
    }
    
    /// Add adapters for supplementary views.
    open func addSupplementaryAdapters(_ adapters: [DPCollectionSupplementaryAdapterType]) {
        for adapter in adapters {
            self.supplementaryAdapters[adapter.modelRepresentID] = adapter
        }
    }
    
    /// Reload data with a new array of sections.
    ///
    /// Install new sections and call `collectionView.reloadData()`.
    ///
    /// - Parameter sections: new array of sections. Will be installed in ``sections``.
    open func reloadData(_ sections: [DPRepresentableSectionType]) {
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
    
    open func modelRepresentID<T: DPRepresentable>(_ model: T) -> ObjectIdentifier {
        ObjectIdentifier(T.self)
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
            let adapter = self.itemAdapters[self.modelRepresentID(model)]
        else { return UICollectionViewCell() }
        
        let cellClass = adapter.cellClass
        let cellIdentifier = String(describing: cellClass)
        
        if !self.registeredСellReuseIdentifiers.contains(cellIdentifier) {
            collectionView.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
            self.registeredСellReuseIdentifiers.insert(cellIdentifier)
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? DPCollectionItemCellType {
            cell._model = model
            
            self.onCellForItem?((cell, model, indexPath))
            adapter.onCell(cell: cell, model: model, indexPath: indexPath)
        }
        
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var result: UICollectionReusableView?
        
        func view(of model: DPAnyRepresentable, kind: String) -> UICollectionReusableView? {
            guard let adapter = self.supplementaryAdapters[self.modelRepresentID(model)] else { return nil }
            
            let viewClass = adapter.viewClass
            let viewIdentifier = String(describing: viewClass)
            
            if !self.registeredSupplementaryViewsReuseIdentifiers.contains(viewIdentifier) {
                collectionView.register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: viewIdentifier)
                self.registeredSupplementaryViewsReuseIdentifiers.insert(viewIdentifier)
            }
            
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: viewIdentifier, for: indexPath)
            
            if let view = view as? DPCollectionSupplementaryViewType {
                view._model = model
            }
            
            return view
        }
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let model = self.sections.header(at: indexPath.section) else { break }
            result = view(of: model, kind: kind)
        case UICollectionView.elementKindSectionFooter:
            guard let model = self.sections.footer(at: indexPath.section) else { break }
            result = view(of: model, kind: kind)
        default:
            break
        }
        
        return result ?? UICollectionReusableView()
    }
    
    // MARK: - UICollectionViewDelegate
    open func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? DPCollectionItemCellType, let model = self.sections.item(at: indexPath) {
            self.willDisplayItem?((cell, model, indexPath))
            self.itemAdapters[self.modelRepresentID(model)]?.willDisplay(cell: cell, model: model, indexPath: indexPath)
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
            let cell = collectionView.cellForItem(at: indexPath) as? DPCollectionItemCellType,
            let model = self.sections.item(at: indexPath)
        else { return }

        self.didSelectItem?((cell, model, indexPath))
        self.itemAdapters[self.modelRepresentID(model)]?.didSelect(cell: cell, model: model, indexPath: indexPath)
    }

    open func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard
            let cell = collectionView.cellForItem(at: indexPath) as? DPCollectionItemCellType,
            let model = self.sections.item(at: indexPath)
        else { return }

        self.didDeselectItem?((cell, model, indexPath))
        self.itemAdapters[self.modelRepresentID(model)]?.didDeselect(cell: cell, model: model, indexPath: indexPath)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let defaultValue: CGSize = (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
        
        guard let model = self.sections.item(at: indexPath) else { return defaultValue }
        let adapter = self.itemAdapters[self.modelRepresentID(model)]
        
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

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard
            let model = self.sections.header(at: section),
            let adapter = self.supplementaryAdapters[self.modelRepresentID(model)]
        else { return .zero }
        
        return
            adapter.onViewSize(model: model, section: section) ??
            self.onReferenceSizeForFooterInSection?((model, section)) ??
            (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ??
            .zero
    }

    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard
            let model = self.sections.footer(at: section),
            let adapter = self.supplementaryAdapters[self.modelRepresentID(model)]
        else { return .zero }
        
        return
            adapter.onViewSize(model: model, section: section) ??
            self.onReferenceSizeForFooterInSection?((model, section)) ??
            (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ??
            .zero
    }
    
}
