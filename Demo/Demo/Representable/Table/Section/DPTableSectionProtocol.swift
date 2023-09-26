//
//  DPTableSectionProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation

public protocol DPTableSectionProtocol {
    var rows: [DPRepresentableModel] { get set }
    var header: DPRepresentableModel? { get set }
    var footer: DPRepresentableModel? { get set }
}

// MARK: - Default
public extension DPTableSectionProtocol {
    
    func row(at index: Int) -> DPRepresentableModel? {
        guard self.rows.indices.contains(index) else { return nil }
        return self.rows[index]
    }
    
}

// MARK: - Array + DPTableSection
public extension Array where Element == DPTableSectionProtocol {
    
    func row(at indexPath: IndexPath) -> DPRepresentableModel? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].row(at: indexPath.row)
    }
    
    func header(at index: Int) -> DPRepresentableModel? {
        guard self.indices.contains(index) else { return nil }
        return self[index].header
    }
    
    func footer(at index: Int) -> DPRepresentableModel? {
        guard self.indices.contains(index) else { return nil }
        return self[index].footer
    }
    
}
