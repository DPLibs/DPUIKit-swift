//
//  DPTableTitleAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation
import UIKit

public protocol DPTableTitleAdapterProtocol {
    var modelRepresentableIdentifier: String { get }
    var viewClass: DPTableTitleViewProtocol.Type { get }
    
    func onViewHeight(model: DPRepresentableModel, section: Int) -> CGFloat?
    func onViewEstimatedHeight(model: DPRepresentableModel, section: Int) -> CGFloat?
}

open class DPTableTitleAdapter<View: DPTableTitleViewProtocol, Model: DPRepresentableModel>: DPTableTitleAdapterProtocol {
    
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
    public let modelRepresentableIdentifier: String = DPRepresentableIdentifier.produce(Model.self)
    public let viewClass: DPTableTitleViewProtocol.Type = View.self
    
    open var viewHeight: CGFloat?
    open var viewEstimatedHeight: CGFloat?
    
    open var onViewHeight: TitleContextToCGFloat?
    open var onViewEstimatedHeight: TitleContextToCGFloat?
    
    // MARK: - Methods
    open func onViewHeight(model: DPRepresentableModel, section: Int) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onViewHeight?((model, section)) ?? self.viewHeight
    }
    
    open func onViewEstimatedHeight(model: DPRepresentableModel, section: Int) -> CGFloat? {
        guard let model = model as? Model else { return nil }
        return self.onViewEstimatedHeight?((model, section)) ?? self.viewEstimatedHeight
    }
}
