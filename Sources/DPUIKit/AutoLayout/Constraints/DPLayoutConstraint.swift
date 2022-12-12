//
//  DPLayoutConstraint.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.11.2022.
//

import Foundation
import UIKit

public final class DPLayoutConstraint: NSLayoutConstraint, DPConstraint {
    
    public convenience init<AnchorType: AnyObject>(
        _ anchor: NSLayoutAnchor<AnchorType>,
        to relatedAnchor: NSLayoutAnchor<AnchorType>,
        constant: CGFloat = 0,
        relation: DPLayoutRelation = .equal
    ) {
        let constraint: NSLayoutConstraint = {
            switch relation {
            case .equal:
                return anchor.constraint(equalTo: relatedAnchor, constant: constant)
            case .lessThanOrEqual:
                return anchor.constraint(lessThanOrEqualTo: relatedAnchor, constant: constant)
            case .greaterThanOrEqual:
                return anchor.constraint(greaterThanOrEqualTo: relatedAnchor, constant: constant)
            }
        }()
        
        self.init(
            item: constraint.firstItem as Any,
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: constraint.multiplier,
            constant: constraint.constant
        )
    }
    
    public convenience init(
        _ anchor: NSLayoutDimension,
        to relatedAnchor: NSLayoutDimension,
        constant: CGFloat = 0,
        multiplier: CGFloat = 1,
        relation: DPLayoutRelation = .equal
    ) {
        let constraint: NSLayoutConstraint = {
            switch relation {
            case .equal:
                return anchor.constraint(equalTo: relatedAnchor, multiplier: multiplier, constant: constant)
            case .lessThanOrEqual:
                return anchor.constraint(lessThanOrEqualTo: relatedAnchor, multiplier: multiplier, constant: constant)
            case .greaterThanOrEqual:
                return anchor.constraint(greaterThanOrEqualTo: relatedAnchor, multiplier: multiplier, constant: constant)
            }
        }()
        
        self.init(
            item: constraint.firstItem as Any,
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: constraint.multiplier,
            constant: constraint.constant
        )
    }
    
    public convenience init(
        _ anchor: NSLayoutDimension,
        constant: CGFloat,
        relation: DPLayoutRelation = .equal
    ) {
        let constraint: NSLayoutConstraint = {
            switch relation {
            case .equal:
                return anchor.constraint(equalToConstant: constant)
            case .lessThanOrEqual:
                return anchor.constraint(lessThanOrEqualToConstant: constant)
            case .greaterThanOrEqual:
                return anchor.constraint(greaterThanOrEqualToConstant: constant)
            }
        }()
        
        self.init(
            item: constraint.firstItem as Any,
            attribute: constraint.firstAttribute,
            relatedBy: constraint.relation,
            toItem: constraint.secondItem,
            attribute: constraint.secondAttribute,
            multiplier: constraint.multiplier,
            constant: constraint.constant
        )
    }
    
}
