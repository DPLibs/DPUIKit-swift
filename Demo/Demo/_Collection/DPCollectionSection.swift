//
//  DPCollectionSection.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit
import DPUIKit

/// Protocol for defining a `section` in an ``DPCollectionAdapter/sections``.
public protocol DPCollectionSectionProtocol {
    
    /// An array of table cell models.
    var items: [DPRepresentableModel] { get set }
}

/// Basic implementation of the ``DPCollectionSectionProtocol``.
public struct DPCollectionSection: DPCollectionSectionProtocol {
    
    public init(items: [DPRepresentableModel] = []) {
        self.items = items
    }
    
    public var items: [DPRepresentableModel]
}

// MARK: - DPCollectionSectionProtocol + Methods
public extension DPCollectionSectionProtocol {
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter index: cell number in the section.
    func item(at index: Int) -> DPRepresentableModel? {
        guard self.items.indices.contains(index) else { return nil }
        return self.items[index]
    }
    
}

// MARK: - DPCollectionSectionProtocol + Array
public extension Array where Element == DPCollectionSectionProtocol {
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter indexPath: cell [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPCollectionView``.
    func item(at indexPath: IndexPath) -> DPRepresentableModel? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].item(at: indexPath.item)
    }
    
    /// Returns the section or `nil`.
    ///
    /// - Parameter index: section number in the sections.
    func section(at index: Int) -> DPCollectionSectionProtocol? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
    
}
