//
//  DPSizeConstraint.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.10.2022.
//

import Foundation
import UIKit

public final class DPSizeConstraint: DPConstraint {
    
    // MARK: - Init
    init(
        widthConstraint: NSLayoutConstraint,
        heightConstraint: NSLayoutConstraint
    ) {
        self.widthConstraint = widthConstraint
        self.heightConstraint = heightConstraint
    }
    
    public init(
        _ view: UIView,
        size: CGSize
    ) {
        self.widthConstraint = view.widthAnchor.constraint(equalToConstant: size.width)
        self.heightConstraint = view.heightAnchor.constraint(equalToConstant: size.height)
    }
    
    public init(
        _ view: UIView,
        widthAnchor: DimensionAnchor,
        heightAnchor: DimensionAnchor
    ) {
        self.widthConstraint = DPLayoutConstraint(
            view.widthAnchor,
            to: widthAnchor.anchor,
            constant: widthAnchor.constant,
            multiplier: widthAnchor.multiplier,
            relation: widthAnchor.relation
        )
        
        self.heightConstraint = DPLayoutConstraint(
            view.heightAnchor,
            to: heightAnchor.anchor,
            constant: heightAnchor.constant,
            multiplier: heightAnchor.multiplier,
            relation: heightAnchor.relation
        )
    }
    
    public init(
        _ view: UIView,
        widthConstant: DimensionConstant,
        heightConstant: DimensionConstant
    ) {
        self.widthConstraint = DPLayoutConstraint(
            view.widthAnchor,
            constant: widthConstant.constant,
            relation: widthConstant.relation
        )
        
        self.heightConstraint = DPLayoutConstraint(
            view.heightAnchor,
            constant: heightConstant.constant,
            relation: heightConstant.relation
        )
    }
    
    // MARK: - Props
    public let widthConstraint: NSLayoutConstraint
    public let heightConstraint: NSLayoutConstraint
    
    public var isActive: Bool {
        get {
            [
                self.widthConstraint,
                self.heightConstraint
            ].allSatisfy({ $0.isActive })
        }
        set {
            [
                self.widthConstraint,
                self.heightConstraint
            ].forEach({ $0.isActive = newValue })
        }
    }
    
    public var size: CGSize {
        get {
            CGSize(
                width: self.widthConstraint.constant,
                height: self.heightConstraint.constant
            )
        }
        set {
            self.widthConstraint.constant = newValue.width
            self.heightConstraint.constant = newValue.height
        }
    }
    
}

// MARK: - DimensionRelatedAnchor
public extension DPSizeConstraint {
    
    struct DimensionAnchor {
        
        // MARK: - Init
        public init(
            anchor: NSLayoutDimension,
            constant: CGFloat = 0,
            multiplier: CGFloat = 1,
            relation: DPLayoutRelation = .equal
        ) {
            self.anchor = anchor
            self.constant = constant
            self.multiplier = multiplier
            self.relation = relation
        }
        
        // MARK: - Props
        public let anchor: NSLayoutDimension
        public let constant: CGFloat
        public let multiplier: CGFloat
        public let relation: DPLayoutRelation
    }
    
}

// MARK: - DimensionRelatedAnchor
public extension DPSizeConstraint {
    
    struct DimensionConstant {
        
        // MARK: - Init
        public init(
            constant: CGFloat,
            relation: DPLayoutRelation = .equal
        ) {
            self.constant = constant
            self.relation = relation
        }
        
        // MARK: - Props
        public let constant: CGFloat
        public let relation: DPLayoutRelation
    }
    
}
