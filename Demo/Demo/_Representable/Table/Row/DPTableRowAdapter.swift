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
    var cellHeight: CGFloat? { get }
    var cellEstimatedHeight: CGFloat? { get }
    
    func handleDidSelect(_ context: DPTableRowContext)
    func handleDidDeselect(_ context: DPTableRowContext)
    func handleOnCell(_ context: DPTableRowContext)
    func handleWillDisplay(_ context: DPTableRowContext)
    func handleWillBeginEditing(_ context: DPTableRowContext)
    func handleDidEndEditing(_ context: DPTableRowContext)
    func handleOnCellLeading(_ context: DPTableRowContext) -> UISwipeActionsConfiguration?
    func handleOnCellTrailing(_ context: DPTableRowContext) -> UISwipeActionsConfiguration?
}

// MARK: - Protocol - Default
public extension DPTableRowAdapterProtocol {
    var cellHeight: CGFloat? { nil }
    var cellEstimatedHeight: CGFloat? { nil }
    
    func handleDidSelect(_ context: DPTableRowContext) {}
    func handleDidDeselect(_ context: DPTableRowContext) {}
    func handleOnCell(_ context: DPTableRowContext) {}
    func handleWillDisplay(_ context: DPTableRowContext) {}
    func handleWillBeginEditing(_ context: DPTableRowContext) {}
    func handleDidEndEditing(_ context: DPTableRowContext) {}
    func handleOnCellLeading(_ context: DPTableRowContext) -> UISwipeActionsConfiguration? { nil }
    func handleOnCellTrailing(_ context: DPTableRowContext) -> UISwipeActionsConfiguration? { nil }
}

open class DPTableRowAdapter<Cell: DPTableRowCellProtocol, Model: DPRepresentableModel>: DPTableRowAdapterProtocol {
    
    // MARK: - Init
    public init(
        didSelect: RowContextClosure? = nil,
        didDeselect: RowContextClosure? = nil,
        onCell: RowContextClosure? = nil,
        willDisplay: RowContextClosure? = nil,
        willBeginEditing: RowContextClosure? = nil,
        didEndEditing: RowContextClosure? = nil,
        onCellLeading: RowContextToSwipeActionsConfiguration? = nil,
        onCellTrailing: RowContextToSwipeActionsConfiguration? = nil
    ) {
        self.didSelect = didSelect
        self.didDeselect = didDeselect
        self.onCell = onCell
        self.willDisplay = willDisplay
        self.willBeginEditing = willBeginEditing
        self.didEndEditing = didEndEditing
        self.onCellLeading = onCellLeading
        self.onCellTrailing = onCellTrailing
    }
    
    // MARK: - Types
    public typealias RowContext = (cell: Cell, model: Model, indexPath: IndexPath)
    public typealias RowContextClosure = (RowContext) -> Void
    public typealias RowContextToSwipeActionsConfiguration = (RowContext) -> UISwipeActionsConfiguration?
    
    // MARK: - Props
    public let modelRepresentableIdentifier: String = DPRepresentableIdentifier.produce(Model.self)
    public let cellClass: DPTableRowCellProtocol.Type = Cell.self
    
    open var cellHeight: CGFloat?
    open var cellEstimatedHeight: CGFloat?
    
    open var didSelect: RowContextClosure?
    open var didDeselect: RowContextClosure?
    open var onCell: RowContextClosure?
    open var willDisplay: RowContextClosure?
    open var willBeginEditing: RowContextClosure?
    open var didEndEditing: RowContextClosure?
    open var onCellLeading: RowContextToSwipeActionsConfiguration?
    open var onCellTrailing: RowContextToSwipeActionsConfiguration?
    
    // MARK: - Methods
    open func resolveRowContext(of commonContext: DPTableRowContext) -> RowContext? {
        guard let cell = commonContext.cell as? Cell, let model = commonContext.model as? Model else { return nil }
        return (cell, model, commonContext.indexPath)
    }
    
    open func handleDidSelect(_ context: DPTableRowContext) {
        guard let context = self.resolveRowContext(of: context) else { return }
        self.didSelect?(context)
    }
    
    open func handleDidDeselect(_ context: DPTableRowContext) {
        guard let context = self.resolveRowContext(of: context) else { return }
        self.didDeselect?(context)
    }
    
    open func handleOnCell(_ context: DPTableRowContext) {
        guard let context = self.resolveRowContext(of: context) else { return }
        self.onCell?(context)
    }
    
    open func handleWillDisplay(_ context: DPTableRowContext) {
        guard let context = self.resolveRowContext(of: context) else { return }
        self.willDisplay?(context)
    }
    
    open func handleWillBeginEditing(_ context: DPTableRowContext) {
        guard let context = self.resolveRowContext(of: context) else { return }
        self.willBeginEditing?(context)
    }
    
    open func handleDidEndEditing(_ context: DPTableRowContext) {
        guard let context = self.resolveRowContext(of: context) else { return }
        self.didEndEditing?(context)
    }
    
    open func handleOnCellLeading(_ context: DPTableRowContext) -> UISwipeActionsConfiguration? {
        guard let context = self.resolveRowContext(of: context) else { return nil }
        return self.onCellLeading?(context)
    }
    
    open func handleOnCellTrailing(_ context: DPTableRowContext) -> UISwipeActionsConfiguration? {
        guard let context = self.resolveRowContext(of: context) else { return nil }
        return self.onCellTrailing?(context)
    }
}
