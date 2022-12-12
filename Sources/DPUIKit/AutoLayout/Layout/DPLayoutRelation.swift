//
//  DPLayoutRelation.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.10.2022.
//

import Foundation
import UIKit

public enum DPLayoutRelation: Int {
    case lessThanOrEqual = -1
    case equal = 0
    case greaterThanOrEqual = 1
}

// MARK: - DPLayoutRelation + NSLayoutConstraint.Relation
public extension DPLayoutRelation {
    
    init?(relation: NSLayoutConstraint.Relation) {
        switch relation {
        case .lessThanOrEqual:
            self = .lessThanOrEqual
        case .equal:
            self = .equal
        case .greaterThanOrEqual:
            self = .greaterThanOrEqual
        @unknown default:
            return nil
        }
    }
    
    var relation: NSLayoutConstraint.Relation {
        switch self {
        case .lessThanOrEqual:
            return .lessThanOrEqual
        case .equal:
            return .equal
        case .greaterThanOrEqual:
            return .greaterThanOrEqual
        }
    }
    
}
