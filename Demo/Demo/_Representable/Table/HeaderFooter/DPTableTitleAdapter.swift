//
//  DPTableTitleAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation

public protocol DPTableTitleAdaptable {
    var modelRepresentableIdentifier: String { get }
    var viewClass: DPTableTitleViewProtocol.Type { get }
    
    var viewHeight: CGFloat? { get }
    var viewEstimatedHeight: CGFloat? { get }
}

// MARK: - Default
extension DPTableTitleAdaptable {
    var viewHeight: CGFloat? { nil }
    var viewEstimatedHeight: CGFloat? { nil }
}

open class DPTableTitleAdapter<View: DPTableTitleViewProtocol, Model: DPRepresentableModel>: DPTableTitleAdaptable {
    
    // MARK: - Init
    public init(
        viewHeight: CGFloat? = nil,
        viewEstimatedHeight: CGFloat? = nil
    ) {
        self.viewHeight = viewHeight
        self.viewEstimatedHeight = viewEstimatedHeight
    }
    
    // MARK: - Props
    public let modelRepresentableIdentifier: String = DPRepresentableIdentifier.produce(Model.self)
    public let viewClass: DPTableTitleViewProtocol.Type = View.self
    
    open var viewHeight: CGFloat?
    open var viewEstimatedHeight: CGFloat?
}
