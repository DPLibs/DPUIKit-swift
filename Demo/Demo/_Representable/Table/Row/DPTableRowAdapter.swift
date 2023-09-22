//
//  DPTableRowAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation
import UIKit

public protocol DPTableRowAdapterProtocol {
    var modelRepresentableIdentifier: String { get }
    var cellClass: DPTableRowCellProtocol.Type { get }
    
    func didSelect(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    func didDeselect(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    func onCell(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    func willDisplay(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    func onCellHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat?
    func onCellEstimatedHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat?
    func willBeginEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    func didEndEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    func onCellLeading(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration?
    func onCellTrailing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration?
}

open class DPTableRowAdapter<Cell: DPTableRowCellProtocol, Model: DPRepresentableModel>: DPTableRowAdapterProtocol {
    
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
    public let modelRepresentableIdentifier: String = DPRepresentableIdentifier.produce(Model.self)
    public let cellClass: DPTableRowCellProtocol.Type = Cell.self
    
    open var cellHeight: CGFloat?
    open var cellEstimatedHeight: CGFloat?
    
    open var didSelect: RowContextClosure?
    open var didDeselect: RowContextClosure?
    open var onCell: RowContextClosure?
    open var willDisplay: RowContextClosure?
    open var onCellHeight: RowContextToCGFloat?
    open var onCellEstimatedHeight: RowContextToCGFloat?
    open var willBeginEditing: RowContextClosure?
    open var didEndEditing: RowContextClosure?
    open var onCellLeading: RowContextToSwipeActionsConfiguration?
    open var onCellTrailing: RowContextToSwipeActionsConfiguration?
    
    // MARK: - Methods
    open func didSelect(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didSelect?((cell, model, indexPath))
    }
    
    open func didDeselect(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didDeselect?((cell, model, indexPath))
    }
    
    open func onCell(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.onCell?((cell, model, indexPath))
    }
    
    open func willDisplay(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.willDisplay?((cell, model, indexPath))
    }
    
    open func onCellHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onCellHeight?((model, indexPath)) ?? self.cellHeight
    }
    
    open func onCellEstimatedHeight(model: DPRepresentableModel, indexPath: IndexPath) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onCellEstimatedHeight?((model, indexPath)) ?? self.cellEstimatedHeight
    }
    
    open func willBeginEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.willBeginEditing?((cell, model, indexPath))
    }
    
    open func didEndEditing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) {
        guard let cell = cell as? Cell, let model = model as? Model else { return }
        self.didEndEditing?((cell, model, indexPath))
    }
    
    open func onCellLeading(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = cell as? Cell, let model = model as? Model else { return nil }
        return self.onCellLeading?((cell, model, indexPath))
    }
    
    open func onCellTrailing(cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let cell = cell as? Cell, let model = model as? Model else { return nil }
        return self.onCellTrailing?((cell, model, indexPath))
    }
}
