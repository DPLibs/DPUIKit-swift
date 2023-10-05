//
//  DPCollectionSupplementaryAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 04.10.2023.
//

import Foundation

/// Component for managing a [UICollectionReusableView](https://developer.apple.com/documentation/uikit/uicollectionreusableview).
public protocol DPCollectionSupplementaryAdapterType {
    
    /// Model reuse identifier.
    /// This property is used to search for a match between the adapter and the model.
    var modelRepresentableIdentifier: String { get }
    
    /// View type.
    /// Using this property, the view is registered in the table, and the view is returned in ``DPCollectionAdapter/collectionView(_:viewForSupplementaryElementOfKind:at:)``.
    var viewClass: DPCollectionSupplementaryViewType.Type { get }
    
    /// Called in the ``DPCollectionAdapter/collectionView(_:layout:referenceSizeForHeaderInSection:)`` or ``DPCollectionAdapter/collectionView(_:layout:referenceSizeForFooterInSection:)``.
    func onViewSize(model: DPRepresentableModel, section: Int) -> CGSize?
}

/// Basic implementation of the ``DPCollectionSupplementaryAdapterType``.
open class DPCollectionSupplementaryAdapter<View: DPCollectionSupplementaryViewType, Model: DPRepresentableModel>: DPCollectionSupplementaryAdapterType {
    
    // MARK: - Init
    public init(
        viewSize: CGSize? = nil,
        onViewSize: SupplementaryContextToCGSize? = nil
    ) {
        self.viewSize = viewSize
        self.onViewSize = onViewSize
    }
    
    // MARK: - Types
    public typealias SupplementaryContextToCGSize = ((model: Model, section: Int)) -> CGSize?
    
    // MARK: - Props
    public let modelRepresentableIdentifier: String = DPRepresentableIdentifier.produce(Model.self)
    public let viewClass: DPCollectionSupplementaryViewType.Type = View.self
    
    /// The value of this property will be returned ``onViewSize(model:section:)`` if ``onViewSize`` is not defined.
    open var viewSize: CGSize?
    
    /// Called in the ``onViewSize(model:section:)``.
    open var onViewSize: SupplementaryContextToCGSize?
    
    // MARK: - Methods
    open func onViewSize(model: DPRepresentableModel, section: Int) -> CGSize? {
        guard let model = model as? Model else { return nil }
        return self.onViewSize?((model, section)) ?? self.viewSize
    }
}
