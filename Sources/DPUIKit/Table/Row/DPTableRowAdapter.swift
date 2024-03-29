//
//  DPTableRowAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation
import UIKit

/// Component for managing a [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell).
public protocol DPTableRowAdapterType {
    
    /// Model reuse identifier.
    /// This property is used to search for a match between adapter and model.
    var modelReprentID: ObjectIdentifier { get }
    
    /// Cell type.
    /// Using this property, the cell is registered in the table, and the cell is returned in the ``DPTableAdapter/tableView(_:cellForRowAt:)``.
    var cellClass: DPTableRowCellType.Type { get }
    
    /// Called in the ``DPTableAdapter/tableView(_:didSelectRowAt:)``.
    func didSelect(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath)
    
    /// Called in the ``DPTableAdapter/tableView(_:didDeselectRowAt:)``.
    func didDeselect(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath)
    
    /// Called in the ``DPTableAdapter/tableView(_:cellForRowAt:)``.
    func onCell(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath)
    
    /// Called in the ``DPTableAdapter/tableView(_:willDisplay:forRowAt:)``.
    func willDisplay(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath)
    
    /// Called in the ``DPTableAdapter/tableView(_:heightForRowAt:)``.
    func onCellHeight(model: Sendable, indexPath: IndexPath) -> CGFloat?
    
    /// Called in the ``DPTableAdapter/tableView(_:estimatedHeightForRowAt:)``.
    func onCellEstimatedHeight(model: Sendable, indexPath: IndexPath) -> CGFloat?
    
    /// Called in the ``DPTableAdapter/tableView(_:willBeginEditingRowAt:)``.
    func willBeginEditing(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath)
    
    /// Called in the ``DPTableAdapter/tableView(_:didEndEditingRowAt:)``.
    func didEndEditing(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath)
    
    /// Called in the ``DPTableAdapter/tableView(_:leadingSwipeActionsConfigurationForRowAt:)``.
    func onCellLeading(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) -> UISwipeActionsConfiguration?
    
    /// Called in the ``DPTableAdapter/tableView(_:trailingSwipeActionsConfigurationForRowAt:)``.
    func onCellTrailing(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) -> UISwipeActionsConfiguration?
}

/// Basic implementation of the ``DPTableRowAdapterType``.
open class DPTableRowAdapter<Cell: DPTableRowCellType, Model: Sendable>: DPTableRowAdapterType {
    
    // MARK: - Init
    public init(
        cellHeight: CGFloat? = nil,
        cellEstimatedHeight: CGFloat? = nil,
        didSelect: RowContextClosure? = nil,
        didDeselect: RowContextClosure? = nil,
        onCell: RowContextClosure? = nil,
        willDisplay: RowContextClosure? = nil,
        onCellHeight: RowContextToCGFloat? = nil,
        onCellEstimatedHeight: RowContextToCGFloat? = nil,
        willBeginEditing: RowContextClosure? = nil,
        didEndEditing: RowContextClosure? = nil,
        onCellLeading: RowContextToSwipeActionsConfiguration? = nil,
        onCellTrailing: RowContextToSwipeActionsConfiguration? = nil
    ) {
        self.cellHeight = cellHeight
        self.cellEstimatedHeight = cellEstimatedHeight
        self.didSelect = didSelect
        self.didDeselect = didDeselect
        self.onCell = onCell
        self.willDisplay = willDisplay
        self.onCellHeight = onCellHeight
        self.onCellEstimatedHeight = onCellEstimatedHeight
        self.willBeginEditing = willBeginEditing
        self.didEndEditing = didEndEditing
        self.onCellLeading = onCellLeading
        self.onCellTrailing = onCellTrailing
    }
    
    // MARK: - Types
    public typealias RowContext = (cell: Cell, model: Model, indexPath: IndexPath)
    public typealias RowContextClosure = (RowContext) -> Void
    public typealias RowContextToSwipeActionsConfiguration = (RowContext) -> UISwipeActionsConfiguration?
    public typealias RowContextToCGFloat = ((model: Model, indexPath: IndexPath)) -> CGFloat?
    
    // MARK: - Props
    public let modelReprentID = ObjectIdentifier(Model.self)
    public let cellClass: DPTableRowCellType.Type = Cell.self
    
    /// The value of this property will be returned ``onCellHeight(model:indexPath:)`` if ``onCellHeight`` is not defined.
    open var cellHeight: CGFloat?
    
    /// The value of this property will be returned ``onCellEstimatedHeight(model:indexPath:)`` if ``onCellEstimatedHeight`` is not defined.
    open var cellEstimatedHeight: CGFloat?
    
    /// Called in the ``didSelect(cell:model:indexPath:)``.
    open var didSelect: RowContextClosure?
    
    /// Called in the ``didDeselect(cell:model:indexPath:)``.
    open var didDeselect: RowContextClosure?
    
    /// Called in the ``onCell(cell:model:indexPath:)``.
    open var onCell: RowContextClosure?
    
    /// Called in the ``willDisplay(cell:model:indexPath:)``.
    open var willDisplay: RowContextClosure?
    
    /// Called in the ``onCellHeight(model:indexPath:)``.
    open var onCellHeight: RowContextToCGFloat?
    
    /// Called in the ``onCellEstimatedHeight(model:indexPath:)``.
    open var onCellEstimatedHeight: RowContextToCGFloat?
    
    /// Called in the ``willBeginEditing(cell:model:indexPath:)``.
    open var willBeginEditing: RowContextClosure?
    
    /// Called in the ``didEndEditing(cell:model:indexPath:)``.
    open var didEndEditing: RowContextClosure?
    
    /// Called in the ``onCellLeading(cell:model:indexPath:)``.
    open var onCellLeading: RowContextToSwipeActionsConfiguration?
    
    /// Called in the ``onCellTrailing(cell:model:indexPath:)``.
    open var onCellTrailing: RowContextToSwipeActionsConfiguration?
    
    // MARK: - Methods
    open func didSelect(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didSelect?((cell, model, indexPath))
    }
    
    open func didDeselect(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didDeselect?((cell, model, indexPath))
    }
    
    open func onCell(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.onCell?((cell, model, indexPath))
    }
    
    open func willDisplay(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.willDisplay?((cell, model, indexPath))
    }
    
    open func onCellHeight(model: Sendable, indexPath: IndexPath) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onCellHeight?((model, indexPath)) ?? self.cellHeight
    }
    
    open func onCellEstimatedHeight(model: Sendable, indexPath: IndexPath) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onCellEstimatedHeight?((model, indexPath)) ?? self.cellEstimatedHeight
    }
    
    open func willBeginEditing(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.willBeginEditing?((cell, model, indexPath))
    }
    
    open func didEndEditing(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didEndEditing?((cell, model, indexPath))
    }
    
    open func onCellLeading(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = cell as? Cell, let model = model as? Model else { return nil }
        return self.onCellLeading?((cell, model, indexPath))
    }
    
    open func onCellTrailing(cell: DPTableRowCellType, model: Sendable, indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = cell as? Cell, let model = model as? Model else { return nil }
        return self.onCellTrailing?((cell, model, indexPath))
    }
}
