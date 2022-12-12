//
//  DPConstraintWrapper+Center.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.11.2022.
//

import Foundation
import UIKit

public extension DPConstraintWrapper {
    
    static func centerX(
        _ constant: CGFloat = 0,
        to anchorType: DPLayoutGuideAnchorType<NSLayoutXAxisAnchor> = .superview,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let anchor: NSLayoutXAxisAnchor = {
                switch anchorType {
                case .superview:
                    return superview.centerXAnchor
                case .safeArea:
                    return superview.safeAreaLayoutGuide.centerXAnchor
                case let .anchor(anchor):
                    return anchor
                }
            }()
            
            DPLayoutConstraint(view.centerXAnchor, to: anchor, constant: constant, relation: relation).activate()
        }
    }
    
    static func centerY(
        _ constant: CGFloat = 0,
        to anchorType: DPLayoutGuideAnchorType<NSLayoutYAxisAnchor> = .superview,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let anchor: NSLayoutYAxisAnchor = {
                switch anchorType {
                case .superview:
                    return superview.centerYAnchor
                case .safeArea:
                    return superview.safeAreaLayoutGuide.centerYAnchor
                case let .anchor(anchor):
                    return anchor
                }
            }()
            
            DPLayoutConstraint(view.centerYAnchor, to: anchor, constant: constant, relation: relation).activate()
        }
    }
    
    static func center(
        _ center: CGPoint = .zero,
        to anchorType: DPLayoutGuideType = .superview,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let layout: DPLayoutGuide = {
                switch anchorType {
                case .superview:
                    return superview
                case .safeArea:
                    return superview.safeAreaLayoutGuide
                case let .layout(layout):
                    return layout
                }
            }()
            
            DPCenterConstraint(view, to: layout, center: center, relation: relation).activate()
        }
    }
    
    static func center(
        xAnchor: DPCenterConstraint.AxisAnchor<NSLayoutXAxisAnchor>,
        yAnchor: DPCenterConstraint.AxisAnchor<NSLayoutYAxisAnchor>
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            DPCenterConstraint(view, xAnchor: xAnchor, yAnchor: yAnchor).activate()
        }
    }
    
}
