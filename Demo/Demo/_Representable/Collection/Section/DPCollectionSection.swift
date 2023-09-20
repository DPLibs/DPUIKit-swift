//
//  DPCollectionSection.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation

public struct DPCollectionSection: DPCollectionSectionProtocol {
    
    public init(
        items: [DPCollectionItemModelProtocol] = []
    ) {
        self.items = items
    }
    
    public var items: [DPCollectionItemModelProtocol]
}
