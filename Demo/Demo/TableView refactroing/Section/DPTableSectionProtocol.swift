//
//  DPTableSectionProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation

public protocol DPTableSectionProtocol {
    var rows: [DPTableViewCellModelProtocol] { get set }
    var header: DPTableViewHeaderFooterViewModelProtocol? { get set }
    var footer: DPTableViewHeaderFooterViewModelProtocol? { get set }
}

// MARK: - Default
public extension DPTableSectionProtocol {
    
    func row(at index: Int) -> DPTableViewCellModelProtocol? {
        guard self.rows.indices.contains(index) else { return nil }
        return self.rows[index]
    }
    
}

// MARK: - Array + DPTableSection
public extension Array where Element == DPTableSectionProtocol {
    
    func row(at indexPath: IndexPath) -> DPTableViewCellModelProtocol? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].row(at: indexPath.row)
    }
    
}
