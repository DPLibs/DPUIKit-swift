//
//  DPCenterConstraint.swift
//  Demo
//
//  Created by Дмитрий Поляков on 12.10.2022.
//

import Foundation
import UIKit

public final class DPCenterConstraint: DPConstraint {
    
    // MARK: - Init
    init(
        xConstraint: NSLayoutConstraint,
        yConstraint: NSLayoutConstraint
    ) {
        self.xConstraint = xConstraint
        self.yConstraint = yConstraint
    }
    
    public init(
        _ view: UIView,
        to layout: DPLayoutGuide,
        center: CGPoint = .zero,
        relation: DPLayoutRelation = .equal
    ) {
        self.xConstraint = DPLayoutConstraint(
            view.centerXAnchor,
            to: layout.centerXAnchor,
            constant: center.x,
            relation: relation
        )
        
        self.yConstraint = DPLayoutConstraint(
            view.centerYAnchor,
            to: layout.centerYAnchor,
            constant: center.y,
            relation: relation
        )
    }
    
    public init(
        _ view: UIView,
        xAnchor: AxisAnchor<NSLayoutXAxisAnchor>,
        yAnchor: AxisAnchor<NSLayoutYAxisAnchor>
    ) {
        self.xConstraint = DPLayoutConstraint(
            view.centerXAnchor,
            to: xAnchor.anchor,
            constant: xAnchor.constant,
            relation: xAnchor.relation
        )
        
        self.yConstraint = DPLayoutConstraint(
            view.centerYAnchor,
            to: yAnchor.anchor,
            constant: yAnchor.constant,
            relation: yAnchor.relation
        )
    }
    
    // MARK: - Props
    public let xConstraint: NSLayoutConstraint
    public let yConstraint: NSLayoutConstraint
    
    public var isActive: Bool {
        get {
            [
                self.xConstraint,
                self.yConstraint
            ].allSatisfy({ $0.isActive })
        }
        set {
            [
                self.xConstraint,
                self.yConstraint
            ].forEach({ $0.isActive = newValue })
        }
    }
    
    public var center: CGPoint {
        get {
            CGPoint(
                x: self.xConstraint.constant,
                y: self.yConstraint.constant
            )
        }
        set {
            self.xConstraint.constant = newValue.x
            self.yConstraint.constant = newValue.y
        }
    }
    
}

// MARK: - AxisReleatedAnchor
public extension DPCenterConstraint {
    
    struct AxisAnchor<AnchorType: AnyObject> {
        
        // MARK: - Init
        public init(
            anchor: NSLayoutAnchor<AnchorType>,
            constant: CGFloat = 0,
            relation: DPLayoutRelation = .equal
        ) {
            self.anchor = anchor
            self.constant = constant
            self.relation = relation
        }
        
        // MARK: - Props
        public let anchor: NSLayoutAnchor<AnchorType>
        public let constant: CGFloat
        public let relation: DPLayoutRelation
    }
    
}
