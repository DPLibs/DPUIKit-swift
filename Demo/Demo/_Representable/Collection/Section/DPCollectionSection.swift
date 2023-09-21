//
//  DPCollectionSection.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

public struct DPCollectionSection: DPCollectionSectionProtocol {
    
    public init(
        items: [DPCollectionItemModelProtocol] = [],
        inset: UIEdgeInsets? = nil
    ) {
        self.items = items
        self.inset = inset
    }
    
    public var items: [DPCollectionItemModelProtocol]
    public var inset: UIEdgeInsets?
}
