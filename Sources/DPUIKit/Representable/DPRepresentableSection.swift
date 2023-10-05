//
//  DPRepresentableSection.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

/// Protocol for defining a `section` in an ``DPCollectionAdapter/sections``.
public protocol DPRepresentableSectionType {
    
    /// An array of table cell models.
    var items: [DPRepresentableModel] { get set }
    
    /// Header model.
    var header: DPRepresentableModel? { get set }
    
    /// Footer model.
    var footer: DPRepresentableModel? { get set }
}

/// Basic implementation of the ``DPRepresentableSectionType``.
public struct DPRepresentableSection: DPRepresentableSectionType {
    
    public init(
        items: [DPRepresentableModel] = [],
        header: DPRepresentableModel? = nil,
        footer: DPRepresentableModel? = nil
    ) {
        self.items = items
        self.header = header
        self.footer = footer
    }
    
    public var items: [DPRepresentableModel]
    public var header: DPRepresentableModel?
    public var footer: DPRepresentableModel?
}

// MARK: - DPRepresentableSectionType + Methods
public extension DPRepresentableSectionType {
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter index: cell number in the section.
    func item(at index: Int) -> DPRepresentableModel? {
        guard self.items.indices.contains(index) else { return nil }
        return self.items[index]
    }
    
}

// MARK: - DPRepresentableSectionType + Array
public extension Array where Element == DPRepresentableSectionType {
    
    /// Returns the section or `nil`.
    ///
    /// - Parameter index: section number in the sections.
    func section(at index: Int) -> DPRepresentableSectionType? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter indexPath: cell [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPCollectionView``.
    func item(at indexPath: IndexPath) -> DPRepresentableModel? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].item(at: indexPath.item)
    }
    
    /// Returns the header model or `nil`.
    ///
    /// - Parameter index: section number.
    func header(at index: Int) -> DPRepresentableModel? {
        guard self.indices.contains(index) else { return nil }
        return self[index].header
    }
    
    /// Returns the footer model or `nil`.
    ///
    /// - Parameter index: section number.
    func footer(at index: Int) -> DPRepresentableModel? {
        guard self.indices.contains(index) else { return nil }
        return self[index].footer
    }
    
}
