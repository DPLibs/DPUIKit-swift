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

//    /// Called in the ``DPTableAdapter/tableView(_:heightForRowAt:)``.
//    func onCellHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat?
//
//    /// Called in the ``DPTableAdapter/tableView(_:estimatedHeightForRowAt:)``.
//    func onCellEstimatedHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat?
//
//    /// Called in the ``DPTableAdapter/tableView(_:willBeginEditingRowAt:)``.
//    func willBeginEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
//
//    /// Called in the ``DPTableAdapter/tableView(_:didEndEditingRowAt:)``.
//    func didEndEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
//
//    /// Called in the ``DPTableAdapter/tableView(_:leadingSwipeActionsConfigurationForRowAt:)``.
//    func onCellLeading(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration?
//
//    /// Called in the ``DPTableAdapter/tableView(_:trailingSwipeActionsConfigurationForRowAt:)``.
//    func onCellTrailing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration?
}

/// Basic implementation of the ``DPCollectionItemAdapterProtocol``.
open class DPCollectionItemAdapter<Cell: DPCollectionItemCellProtocol, Model: DPRepresentableModel>: DPCollectionItemAdapterProtocol {
    
    // MARK: - Init
    public init(
//        cellHeight: CGFloat? = nil,
//        cellEstimatedHeight: CGFloat? = nil,
        didSelect: ItemContextClosure? = nil,
        didDeselect: ItemContextClosure? = nil,
        onCell: ItemContextClosure? = nil,
        willDisplay: ItemContextClosure? = nil
//        onCellHeight: RowContextToCGFloat? = nil,
//        onCellEstimatedHeight: RowContextToCGFloat? = nil,
//        willBeginEditing: RowContextClosure? = nil,
//        didEndEditing: RowContextClosure? = nil,
//        onCellLeading: RowContextToSwipeActionsConfiguration? = nil,
//        onCellTrailing: RowContextToSwipeActionsConfiguration? = nil
    ) {
//        self.cellHeight = cellHeight
//        self.cellEstimatedHeight = cellEstimatedHeight
        self.didSelect = didSelect
        self.didDeselect = didDeselect
        self.onCell = onCell
        self.willDisplay = willDisplay
//        self.onCellHeight = onCellHeight
//        self.onCellEstimatedHeight = onCellEstimatedHeight
//        self.willBeginEditing = willBeginEditing
//        self.didEndEditing = didEndEditing
//        self.onCellLeading = onCellLeading
//        self.onCellTrailing = onCellTrailing
    }
    
    // MARK: - Types
    public typealias ItemContext = (cell: Cell, model: Model, indexPath: IndexPath)
    public typealias ItemContextClosure = (ItemContext) -> Void
    public typealias ItemContextToSwipeActionsConfiguration = (ItemContext) -> UISwipeActionsConfiguration?
    public typealias ItemContextToCGFloat = ((model: Model, indexPath: IndexPath)) -> CGFloat?
    
    // MARK: - Props
    public let modelRepresentableIdentifier: String = DPRepresentableIdentifier.produce(Model.self)
    public let cellClass: DPCollectionItemCellProtocol.Type = Cell.self
    
//    /// The value of this property will be returned ``onCellHeight(model:indexPath:)`` if ``onCellHeight`` is not defined.
//    open var cellHeight: CGFloat?
//
//    /// The value of this property will be returned ``onCellEstimatedHeight(model:indexPath:)`` if ``onCellEstimatedHeight`` is not defined.
//    open var cellEstimatedHeight: CGFloat?
//
    /// Called in the ``didSelect(cell:model:indexPath:)``.
    open var didSelect: ItemContextClosure?

    /// Called in the ``didDeselect(cell:model:indexPath:)``.
    open var didDeselect: ItemContextClosure?

    /// Called in the ``onCell(cell:model:indexPath:)``.
    open var onCell: ItemContextClosure?

    /// Called in the ``willDisplay(cell:model:indexPath:)``.
    open var willDisplay: ItemContextClosure?

//    /// Called in the ``onCellHeight(model:indexPath:)``.
//    open var onCellHeight: RowContextToCGFloat?
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

//    open func onCellHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat? {
//        guard let model = model as? Model else { return nil }
//        return self.onCellHeight?((model, indexPath)) ?? self.cellHeight
//    }
//
//    open func onCellEstimatedHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat? {
//        guard let model = model as? Model else { return nil }
//        return self.onCellEstimatedHeight?((model, indexPath)) ?? self.cellEstimatedHeight
//    }
//
//    open func willBeginEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
//        guard let cell = cell as? Cell, let model = model as? Model else { return }
//        self.willBeginEditing?((cell, model, indexPath))
//    }
//
//    open func didEndEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
//        guard let cell = cell as? Cell, let model = model as? Model else { return }
//        self.didEndEditing?((cell, model, indexPath))
//    }
//
//    open func onCellLeading(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard let cell = cell as? Cell, let model = model as? Model else { return nil }
//        return self.onCellLeading?((cell, model, indexPath))
//    }
//
//    open func onCellTrailing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard let cell = cell as? Cell, let model = model as? Model else { return nil }
//        return self.onCellTrailing?((cell, model, indexPath))
//    }
}
