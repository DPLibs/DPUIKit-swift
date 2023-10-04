//
//  DPRepresentableModel.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation

/// A protocol for creating a reusable model
public protocol DPRepresentableModel: Sendable {

    /// This identifier is used to search for a correspondence between the model and the component responsible for reuse (for example,  ``DPTableRowAdapterProtocol``)
    var _representableIdentifier: String { get }
}

// MARK: - Default
public extension DPRepresentableModel {
    
    /// By default, the value from ``DPRepresentableIdentifier`` is returned for the type that implements this protocol
    var _representableIdentifier: String {
        DPRepresentableIdentifier.produce(Self.self)
    }
    
}
