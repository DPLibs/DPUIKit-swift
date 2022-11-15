//
//  DPConstraintWrapper+AspectRatio.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.11.2022.
//

import Foundation
import UIKit

public extension DPConstraintWrapper {
    
    static func aspectRatio(
        _ multiplier: CGFloat = 1
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            DPLayoutConstraint(view.widthAnchor, to: view.heightAnchor, multiplier: multiplier, relation: .equal).activate()
        }
    }
    
    
}
