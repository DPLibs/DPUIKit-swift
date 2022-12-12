//
//  DPConstraintWrapper+Edge.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.11.2022.
//

import Foundation
import UIKit

public extension DPConstraintWrapper {
    
    static func top(
        _ constant: CGFloat = 0,
        to anchorType: DPLayoutGuideAnchorType<NSLayoutYAxisAnchor> = .superview,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let anchor: NSLayoutYAxisAnchor = {
                switch anchorType {
                case .superview:
                    return superview.topAnchor
                case .safeArea:
                    return superview.safeAreaLayoutGuide.topAnchor
                case let .anchor(anchor):
                    return anchor
                }
            }()
            
            DPLayoutConstraint(view.topAnchor, to: anchor, constant: constant, relation: relation).activate()
        }
    }
    
    static func leading(
        _ constant: CGFloat = 0,
        to anchorType: DPLayoutGuideAnchorType<NSLayoutXAxisAnchor> = .superview,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let anchor: NSLayoutXAxisAnchor = {
                switch anchorType {
                case .superview:
                    return superview.leadingAnchor
                case .safeArea:
                    return superview.safeAreaLayoutGuide.leadingAnchor
                case let .anchor(anchor):
                    return anchor
                }
            }()
            
            DPLayoutConstraint(view.leadingAnchor, to: anchor, constant: constant, relation: relation).activate()
        }
    }
    
    static func bottom(
        _ constant: CGFloat = 0,
        to anchorType: DPLayoutGuideAnchorType<NSLayoutYAxisAnchor> = .superview,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let anchor: NSLayoutYAxisAnchor = {
                switch anchorType {
                case .superview:
                    return superview.bottomAnchor
                case .safeArea:
                    return superview.safeAreaLayoutGuide.bottomAnchor
                case let .anchor(anchor):
                    return anchor
                }
            }()
            
            DPLayoutConstraint(view.bottomAnchor, to: anchor, constant: constant, relation: relation).activate()
        }
    }
    
    static func trailing(
        _ constant: CGFloat = 0,
        to anchorType: DPLayoutGuideAnchorType<NSLayoutXAxisAnchor> = .superview,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let anchor: NSLayoutXAxisAnchor = {
                switch anchorType {
                case .superview:
                    return superview.trailingAnchor
                case .safeArea:
                    return superview.safeAreaLayoutGuide.trailingAnchor
                case let .anchor(anchor):
                    return anchor
                }
            }()
            
            DPLayoutConstraint(view.trailingAnchor, to: anchor, constant: constant, relation: relation).activate()
        }
    }
    
}
