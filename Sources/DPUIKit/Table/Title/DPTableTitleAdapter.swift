//
//  DPTableTitleAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation
import UIKit

/// Component for managing a [UITableViewHeaderFooterView](https://developer.apple.com/documentation/uikit/uitableviewheaderfooterview).
public protocol DPTableTitleAdapterType {
    
    /// Model reuse identifier.
    /// This property is used to search for a match between the adapter and the model.
    var modelRepresentID: ObjectIdentifier { get }
    
    /// View type.
    /// Using this property, the view is registered in the table, and the view is returned in the ``DPTableAdapter/tableView(_:viewForHeaderInSection:)`` or ``DPTableAdapter/tableView(_:viewForFooterInSection:)``.
    var viewClass: DPTableTitleViewType.Type { get }
    
    /// Called in the ``DPTableAdapter/tableView(_:heightForHeaderInSection:)`` or ``DPTableAdapter/tableView(_:heightForFooterInSection:)``.
    func onViewHeight(model: Sendable, section: Int) -> CGFloat?
    
    /// Called in the ``DPTableAdapter/tableView(_:estimatedHeightForHeaderInSection:)`` or ``DPTableAdapter/tableView(_:estimatedHeightForFooterInSection:)``.
    func onViewEstimatedHeight(model: Sendable, section: Int) -> CGFloat?
}

/// Basic implementation of the ``DPTableTitleAdapterType``.
open class DPTableTitleAdapter<View: DPTableTitleViewType, Model: Sendable>: DPTableTitleAdapterType {
    
    // MARK: - Init
    public init(
        viewHeight: CGFloat? = nil,
        viewEstimatedHeight: CGFloat? = nil,
        onViewHeight: TitleContextToCGFloat? = nil,
        onViewEstimatedHeight: TitleContextToCGFloat? = nil
    ) {
        self.viewHeight = viewHeight
        self.viewEstimatedHeight = viewEstimatedHeight
        self.onViewHeight = onViewHeight
        self.onViewEstimatedHeight = onViewEstimatedHeight
    }
    
    // MARK: - Types
    public typealias TitleContextToCGFloat = ((model: Model, section: Int)) -> CGFloat?
    
    // MARK: - Props
    public let modelRepresentID: ObjectIdentifier = ObjectIdentifier(Model.self)
    public let viewClass: DPTableTitleViewType.Type = View.self
    
    /// The value of this property will be returned ``onViewHeight(model:section:)`` if ``onViewHeight`` is not defined.
    open var viewHeight: CGFloat?
    
    /// The value of this property will be returned ``onViewEstimatedHeight(model:section:)`` if ``onViewEstimatedHeight`` is not defined.
    open var viewEstimatedHeight: CGFloat?
    
    /// Called in the ``onViewHeight(model:section:)``.
    open var onViewHeight: TitleContextToCGFloat?
    
    /// Called in the ``onViewEstimatedHeight(model:section:)``.
    open var onViewEstimatedHeight: TitleContextToCGFloat?
    
    // MARK: - Methods
    open func onViewHeight(model: Sendable, section: Int) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onViewHeight?((model, section)) ?? self.viewHeight
    }
    
    open func onViewEstimatedHeight(model: Sendable, section: Int) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onViewEstimatedHeight?((model, section)) ?? self.viewEstimatedHeight
    }
}
