//
//  DPConstraintWrapper.swift
//  Demo
//
//  Created by Дмитрий Поляков on 02.10.2022.
//

import Foundation
import UIKit

public struct DPConstraintWrapper {
    
    // MARK: - Init
    public init(wrap: @escaping (UIView) -> Void) {
        self.wrap = wrap
    }
    
    // MARK: - Props
    public let wrap: (UIView) -> Void
    
}

