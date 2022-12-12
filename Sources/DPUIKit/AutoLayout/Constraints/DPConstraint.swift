//
//  DPConstraint.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.10.2022.
//

import Foundation

public protocol DPConstraint: AnyObject {
    var isActive: Bool { get set }
    
    func activate() -> Self
    func deactivate() -> Self
}

// MARK: - Default
public extension DPConstraint {
    
    @discardableResult
    func activate() -> Self {
        self.isActive = true
        return self
    }
    
    @discardableResult
    func deactivate() -> Self {
        self.isActive = false
        return self
    }
    
}
