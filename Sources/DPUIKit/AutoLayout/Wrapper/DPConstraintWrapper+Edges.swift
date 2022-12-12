//
//  DPConstraintWrapper+Edges.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.11.2022.
//

import Foundation
import UIKit

public extension DPConstraintWrapper {
    
    static func edges(
        _ edges: NSDirectionalEdgeInsets = .zero,
        to layoutType: DPLayoutGuideType = .superview
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            guard let superview = view.superview else { return }
            
            let layout: DPLayoutGuide = {
                switch layoutType {
                case .superview:
                    return superview
                case .safeArea:
                    return superview.safeAreaLayoutGuide
                case let .layout(layout):
                    return layout
                }
            }()
            
            DPEdgesConstraint(view, to: layout, insets: edges).activate()
        }
    }
    
}
