//
//  DPTableSectionProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation

public protocol DPTableSectionProtocol {
    var rows: [DPTableRowModelProtocol] { get set }
    var header: DPTableViewHeaderFooterViewModelProtocol? { get set }
    var footer: DPTableViewHeaderFooterViewModelProtocol? { get set }
}

// MARK: - Default
public extension DPTableSectionProtocol {
    
    func row(at index: Int) -> DPTableRowModelProtocol? {
        guard self.rows.indices.contains(index) else { return nil }
        return self.rows[index]
    }
    
}

// MARK: - Array + DPTableSection
public extension Array where Element == DPTableSectionProtocol {
    
    func row(at indexPath: IndexPath) -> DPTableRowModelProtocol? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].row(at: indexPath.row)
    }
    
    func header(at index: Int) -> DPTableViewHeaderFooterViewModelProtocol? {
        guard self.indices.contains(index) else { return nil }
        return self[index].header
    }
    
    func footer(at index: Int) -> DPTableViewHeaderFooterViewModelProtocol? {
        guard self.indices.contains(index) else { return nil }
        return self[index].footer
    }
    
}
