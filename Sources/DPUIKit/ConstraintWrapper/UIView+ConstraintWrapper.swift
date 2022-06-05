//
//  UIView+ConstraintWrapper.swift
//  
//
//  Created by Дмитрий Поляков on 08.10.2021.
//

import Foundation
import UIKit

public extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ $0.addToSuperview(self) })
    }
    
    @discardableResult
    func addToSuperview(
        _ superview: UIView?,
        withConstraints constraints: [ConstraintWrapper] = []
    ) -> Self {
        self.removeFromSuperview()
        
        guard let superview = superview else { return self }
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addSubview(self)
        
        return self.applyConstraints(array: constraints)
    }
    
    @discardableResult
    func insertToSuperview(
        _ superview: UIView?,
        belowSubview siblingSubview: UIView?,
        withConstraints constraints: [ConstraintWrapper] = []
    ) -> Self {
        self.removeFromSuperview()
        
        guard let superview = superview, let siblingSubview = siblingSubview else { return self }
        self.translatesAutoresizingMaskIntoConstraints = false
        superview.insertSubview(self, belowSubview: siblingSubview)
        
        return self.applyConstraints(array: constraints)
    }
    
    @discardableResult
    func applyConstraints(array constraints: [ConstraintWrapper]) -> Self {
        constraints.forEach({
            switch $0 {
            case let .wrap(constraint):
                constraint(self)
            }
        })
        
        return self
    }
    
    @discardableResult
    func applyConstraints(_ constraints: ConstraintWrapper...) -> Self {
        self.applyConstraints(array: constraints)
    }
    
}
