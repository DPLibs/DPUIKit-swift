//
//  DPLayoutGuideAnchorType.swift
//  Demo
//
//  Created by Дмитрий Поляков on 13.10.2022.
//

import Foundation

public enum DPLayoutGuideAnchorType<AnchorType: AnyObject> {
    case superview
    case safeArea
    case anchor(AnchorType)
}
