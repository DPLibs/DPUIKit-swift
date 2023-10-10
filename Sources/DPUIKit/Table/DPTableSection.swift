//
//  DPTableSection.swift
//
//
//  Created by Дмитрий Поляков on 09.10.2023.
//

import Foundation

/// Protocol for defining a `section` in an ``DPTableAdapter/sections``.
public protocol DPTableSectionType: Sendable {
    
    /// An array of table cell models.
    var rows: [Sendable] { get set }
    
    /// Header model.
    var header: Sendable? { get set }
    
    /// Footer model.
    var footer: Sendable? { get set }
}

/// Basic implementation of the ``DPTableSectionType``.
public struct DPTableSection: DPTableSectionType {
    
    public init(
        rows: [Sendable] = [],
        header: Sendable? = nil,
        footer: Sendable? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }
    
    public var rows: [Sendable]
    public var header: Sendable?
    public var footer: Sendable?
}

// MARK: - DPTableSectionType + Methods
public extension DPTableSectionType {
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter index: cell number in the section.
    func row(at index: Int) -> Sendable? {
        guard self.rows.indices.contains(index) else { return nil }
        return self.rows[index]
    }
    
}

// MARK: - DPTableSectionType + Array
public extension Array where Element == DPTableSectionType {
    
    /// Returns the section or `nil`.
    ///
    /// - Parameter index: section number in the sections.
    func section(at index: Int) -> DPTableSectionType? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter indexPath: cell [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPTableView``.
    func row(at indexPath: IndexPath) -> Sendable? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].row(at: indexPath.row)
    }
    
    /// Returns the header model or `nil`.
    ///
    /// - Parameter index: section number.
    func header(at index: Int) -> Sendable? {
        guard self.indices.contains(index) else { return nil }
        return self[index].header
    }
    
    /// Returns the footer model or `nil`.
    ///
    /// - Parameter index: section number.
    func footer(at index: Int) -> Sendable? {
        guard self.indices.contains(index) else { return nil }
        return self[index].footer
    }
    
}
