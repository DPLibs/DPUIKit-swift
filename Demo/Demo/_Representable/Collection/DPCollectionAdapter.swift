//
//  DPCollectionAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

open class DPCollectionAdapter: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Init
    public override init() {}
    
    // MARK: - Props
    open weak var collectionView: DPCollectionView? {
        didSet {
            self.collectionView?.dataSource = self
            self.collectionView?.delegate = self
        }
    }
    
    open var sections: [DPCollectionSectionProtocol] = []
    open internal(set) var registeredСellIdentifiers: Set<String> = []
    
    open var onCellForItem: DPCollectionItemContextClosure?
    open var willDisplayItem: DPCollectionItemContextClosure?
    open var didSelectItem: DPCollectionItemContextClosure?
    open var didDeselectItem: DPCollectionItemContextClosure?
    
    open var onDisplayFirstItem: (() -> Void)?
    open var onDisplayLastItem: (() -> Void)?
    
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
    
    open func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        print("!!!", kind)
        return UICollectionReusableView()
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
    
}
