//
//  DPRepresentableModel.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation

public protocol DPRepresentableModel {
    var _representableIdentifier: String { get }
}

// MARK: - Default
extension DPRepresentableModel {
    
    var _representableIdentifier: String {
        DPRepresentableIdentifier.produce(Self.self)
    }
    
}
