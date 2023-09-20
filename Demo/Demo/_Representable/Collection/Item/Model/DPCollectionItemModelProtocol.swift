//
//  DPCollectionItemModelProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation

public protocol DPCollectionItemModelProtocol {
    var cellClass: DPCollectionItemCellProtocol.Type { get }
    var cellSize: CGSize? { get }
    
    var onCell: DPCollectionItemContextClosure? { get }
    var willDisplay: DPCollectionItemContextClosure? { get }
    var didSelect: DPCollectionItemContextClosure? { get }
    var didDeselect: DPCollectionItemContextClosure? { get }
}

// MARK: - Default
extension DPCollectionItemModelProtocol {
    var cellSize: CGSize? { nil }
    var onCell: DPCollectionItemContextClosure? { nil }
    var willDisplay: DPCollectionItemContextClosure? { nil }
    var didSelect: DPCollectionItemContextClosure? { nil }
    var didDeselect: DPCollectionItemContextClosure? { nil }
}
