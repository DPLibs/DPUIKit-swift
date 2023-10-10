//
//  DPCollectionItemAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 02.10.2023.
//

import Foundation
import UIKit

/// Component for managing a [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell).
public protocol DPCollectionItemAdapterType {
    
    /// Model reuse identifier.
    /// This property is used to search for a match between adapter and model.
    var modelReuseID: ObjectIdentifier { get }
    
    /// Cell type.
    /// Using this property, the cell is registered in the table, and the cell is returned in the ``DPCollectionAdapter/collectionView(_:cellForItemAt:)``.
    var cellClass: DPCollectionItemCellType.Type { get }
    
    /// Called in the ``DPCollectionAdapter/collectionView(_:didSelectItemAt:)``.
    func didSelect(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:didSelectItemAt:)``.
    func didDeselect(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:cellForItemAt:)``.
    func onCell(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:willDisplay:forItemAt:)``.
    func willDisplay(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:layout:sizeForItemAt:)``.
    func onSizeForItem(model: Sendable, indexPath: IndexPath) -> CGSize?
}

/// Basic implementation of the ``DPCollectionItemAdapterType``.
open class DPCollectionItemAdapter<Cell: DPCollectionItemCellType, Model: Sendable>: DPCollectionItemAdapterType {
    
    // MARK: - Init
    public init(
        cellSize: CGSize? = nil,
        didSelect: ItemContextClosure? = nil,
        didDeselect: ItemContextClosure? = nil,
        onCell: ItemContextClosure? = nil,
        willDisplay: ItemContextClosure? = nil,
        onSizeForItem: ItemContextToCGSize? = nil
    ) {
        self.cellSize = cellSize
        self.didSelect = didSelect
        self.didDeselect = didDeselect
        self.onCell = onCell
        self.willDisplay = willDisplay
        self.onSizeForItem = onSizeForItem
    }
    
    // MARK: - Types
    public typealias ItemContext = (cell: Cell, model: Model, indexPath: IndexPath)
    public typealias ItemContextClosure = (ItemContext) -> Void
    public typealias ItemContextToCGSize = ((model: Model, indexPath: IndexPath)) -> CGSize?
    
    // MARK: - Props
    public let modelReuseID: ObjectIdentifier = ObjectIdentifier(Model.self)
    public let cellClass: DPCollectionItemCellType.Type = Cell.self
    
    /// The value of this property will be returned ``onSizeForItem(model:indexPath:)`` if ``onSizeForItem`` is not defined.
    open var cellSize: CGSize?
    
    /// Called in the ``didSelect(cell:model:indexPath:)``.
    open var didSelect: ItemContextClosure?

    /// Called in the ``didDeselect(cell:model:indexPath:)``.
    open var didDeselect: ItemContextClosure?

    /// Called in the ``onCell(cell:model:indexPath:)``.
    open var onCell: ItemContextClosure?

    /// Called in the ``willDisplay(cell:model:indexPath:)``.
    open var willDisplay: ItemContextClosure?

    /// Called int the ``onSizeForItem(model:indexPath:)``.
    open var onSizeForItem: ItemContextToCGSize?

    // MARK: - Methods
    open func didSelect(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didSelect?((cell, model, indexPath))
    }

    open func didDeselect(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didDeselect?((cell, model, indexPath))
    }

    open func onCell(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.onCell?((cell, model, indexPath))
    }

    open func willDisplay(cell: DPCollectionItemCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.willDisplay?((cell, model, indexPath))
    }

    open func onSizeForItem(model: Sendable, indexPath: IndexPath) -> CGSize? {
        guard let model = model as? Model else { return nil }
        return self.onSizeForItem?((model, indexPath)) ?? self.cellSize
    }
}
