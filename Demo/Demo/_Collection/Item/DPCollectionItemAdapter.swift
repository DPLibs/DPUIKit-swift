//
//  DPCollectionItemAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 02.10.2023.
//

import Foundation
import UIKit
import DPUIKit

/// Component for managing a [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell).
public protocol DPCollectionItemAdapterProtocol {
    
    /// Model reuse identifier.
    /// This property is used to search for a match between ``DPCollectionItemAdapterProtocol`` and ``DPRepresentableModel``.
    var modelRepresentableIdentifier: String { get }
    
    /// Cell type.
    /// Using this property, the cell is registered in the table, and the cell is returned in the ``DPCollectionAdapter/collectionView(_:cellForItemAt:)``.
    var cellClass: DPCollectionItemCellProtocol.Type { get }
    
    /// Called in the ``DPCollectionAdapter/collectionView(_:didSelectItemAt:)``.
    func didSelect(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:didSelectItemAt:)``.
    func didDeselect(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:cellForItemAt:)``.
    func onCell(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:willDisplay:forItemAt:)``.
    func willDisplay(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)

    /// Called in the ``DPCollectionAdapter/collectionView(_:layout:sizeForItemAt:)``.
    func onSizeForItem(model: DPRepresentableModel, indexPath: IndexPath) -> CGSize?
}

/// Basic implementation of the ``DPCollectionItemAdapterProtocol``.
open class DPCollectionItemAdapter<Cell: DPCollectionItemCellProtocol, Model: DPRepresentableModel>: DPCollectionItemAdapterProtocol {
    
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
    public let modelRepresentableIdentifier: String = DPRepresentableIdentifier.produce(Model.self)
    public let cellClass: DPCollectionItemCellProtocol.Type = Cell.self
    
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

    /// Called int the ``collectionView(_:layout:sizeForItemAt:)``.
    open var onSizeForItem: ItemContextToCGSize?
//
//    /// Called in the ``onCellEstimatedHeight(model:indexPath:)``.
//    open var onCellEstimatedHeight: RowContextToCGFloat?
//
//    /// Called in the ``willBeginEditing(cell:model:indexPath:)``.
//    open var willBeginEditing: RowContextClosure?
//
//    /// Called in the ``didEndEditing(cell:model:indexPath:)``.
//    open var didEndEditing: RowContextClosure?
//
//    /// Called in the ``onCellLeading(cell:model:indexPath:)``.
//    open var onCellLeading: RowContextToSwipeActionsConfiguration?
//
//    /// Called in the ``onCellTrailing(cell:model:indexPath:)``.
//    open var onCellTrailing: RowContextToSwipeActionsConfiguration?

    // MARK: - Methods
    open func didSelect(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didSelect?((cell, model, indexPath))
    }

    open func didDeselect(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didDeselect?((cell, model, indexPath))
    }

    open func onCell(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.onCell?((cell, model, indexPath))
    }

    open func willDisplay(cell: DPCollectionItemCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.willDisplay?((cell, model, indexPath))
    }

    open func onSizeForItem(model: DPRepresentableModel, indexPath: IndexPath) -> CGSize? {
        guard let model = model as? Model else { return nil }
        return self.onSizeForItem?((model, indexPath)) ?? self.cellSize
    }
}
