//
//  DPConstraintWrapper+Size.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.11.2022.
//

import Foundation
import UIKit

public extension DPConstraintWrapper {
    
    static func size(_ size: CGSize) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            DPSizeConstraint(view, size: size).activate()
        }
    }
    
    static func size(side: CGFloat) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            DPSizeConstraint(view, size: CGSize(width: side, height: side)).activate()
        }
    }
    
    static func size(
        widthAnchor: DPSizeConstraint.DimensionAnchor,
        heightAnchor: DPSizeConstraint.DimensionAnchor
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            DPSizeConstraint(view, widthAnchor: widthAnchor, heightAnchor: heightAnchor).activate()
        }
    }
    
    static func size(
        widthConstant: DPSizeConstraint.DimensionConstant,
        heightConstant: DPSizeConstraint.DimensionConstant
    ) -> DPConstraintWrapper {
        DPConstraintWrapper { view in
            DPSizeConstraint(view, widthConstant: widthConstant, heightConstant: heightConstant).activate()
        }
    }
    
}
