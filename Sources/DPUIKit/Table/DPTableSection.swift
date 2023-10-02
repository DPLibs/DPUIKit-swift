//
//  DPTableSection.swift
//  
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

/// Protocol for defining a `section` in an ``DPTableAdapter/sections``.
public protocol DPTableSectionProtocol {
    var rows: [DPRepresentableModel] { get set }
    var header: DPRepresentableModel? { get set }
    var footer: DPRepresentableModel? { get set }
}

/// Basic implementation of the ``DPTableSectionProtocol``.
public struct DPTableSection: DPTableSectionProtocol {
    
    // MARK: - Init
    public init(
        rows: [DPRepresentableModel] = [],
        header: DPRepresentableModel? = nil,
        footer: DPRepresentableModel? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }

    // MARK: - Props
    
    /// An array of table cell models.
    public var rows: [DPRepresentableModel]
    
    /// Header model.
    public var header: DPRepresentableModel?
    
    /// Footer model.
    public var footer: DPRepresentableModel?
}

// MARK: - DPTableSection + Methods
public extension DPTableSectionProtocol {
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter index: cell number in the section.
    func row(at index: Int) -> DPRepresentableModel? {
        guard self.rows.indices.contains(index) else { return nil }
        return self.rows[index]
    }
    
}

// MARK: - DPTableSection + Array
public extension Array where Element == DPTableSectionProtocol {
    
    /// Returns the cell model or `nil`.
    ///
    /// - Parameter indexPath: cell [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPTableView``.
    func row(at indexPath: IndexPath) -> DPRepresentableModel? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].row(at: indexPath.row)
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
