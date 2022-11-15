//
//  DPConstraintWrapper+Width.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.11.2022.
//

import Foundation
import UIKit

public extension DPConstraintWrapper {
    
    static func width(
        _ constant: CGFloat,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            DPLayoutConstraint(view.widthAnchor, constant: constant, relation: relation).activate()
        }
    }
    
    static func width(
        _ constant: CGFloat = 0,
        to anchorType: DPLayoutGuideAnchorType<NSLayoutDimension> = .superview,
        multiplier: CGFloat = 1,
        relation: DPLayoutRelation = .equal
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let anchor: NSLayoutDimension = {
                switch anchorType {
                case .superview:
                    return superview.widthAnchor
                case .safeArea:
                    return superview.safeAreaLayoutGuide.widthAnchor
                case let .anchor(anchor):
                    return anchor
                }
            }()
            
            DPLayoutConstraint(view.widthAnchor, to: anchor, constant: constant, multiplier: multiplier, relation: relation).activate()
        }
    }
    
}
