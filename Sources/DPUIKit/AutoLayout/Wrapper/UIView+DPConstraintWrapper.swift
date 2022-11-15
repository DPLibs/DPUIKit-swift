//
//  UIView+DPConstraintWrapper.swift
//  Demo
//
//  Created by Дмитрий Поляков on 02.10.2022.
//

import Foundation
import UIKit

public extension UIView {
    
    @discardableResult
    func addToSuperview(
        _ superview: UIView?,
        as insertType: DPViewInsertMethod = .add,
        withConstraints constraints: [DPConstraintWrapper] = []
    ) -> Self {
        self.removeFromSuperview()
        
        guard let superview = superview else { return self }
        
        switch insertType {
        case .add:
            superview.addSubview(self)
        case let .below(subview):
            guard let subview = subview else { return self }
            superview.insertSubview(self, belowSubview: subview)
        case let .above(subview):
            guard let subview = subview else { return self }
            superview.insertSubview(self, aboveSubview: subview)
        }

        return self.applyConstraints(array: constraints)
    }
    
    @discardableResult
    func applyConstraints(array constraints: [DPConstraintWrapper]) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        constraints.forEach({ constraint in
            constraint.wrap(self)
        })

        return self
    }

    @discardableResult
    func applyConstraints(_ constraints: DPConstraintWrapper...) -> Self {
        self.applyConstraints(array: constraints)
    }
    
}

// MARK: - DPSubviewInsertMethod
public extension UIView {
    
    enum DPViewInsertMethod {
        case add
        case below(_ subview: UIView?)
        case above(_ subview: UIView?)
    }
    
}
