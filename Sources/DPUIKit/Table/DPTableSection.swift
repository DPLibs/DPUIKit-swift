//
//  DPTableSection.swift
//  
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

public protocol DPTableSectionProtocol {
    var rows: [DPRepresentableModel] { get set }
    var header: DPRepresentableModel? { get set }
    var footer: DPRepresentableModel? { get set }
}

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
    public var rows: [DPRepresentableModel]
    public var header: DPRepresentableModel?
    public var footer: DPRepresentableModel?
}

// MARK: - DPTableSection + Methods
public extension DPTableSectionProtocol {
    
    func row(at index: Int) -> DPRepresentableModel? {
        guard self.rows.indices.contains(index) else { return nil }
        return self.rows[index]
    }
    
}

// MARK: - DPTableSection + Array
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
