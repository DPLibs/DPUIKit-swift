//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

open class DPTableSectionModel {

    // MARK: - Props
    open var rows: [DPTableRowModel]
//    open var header: DPTableSectionHeaderModel?
//    open var footer: DPTableSectionHeaderModel?

    // MARK: - Init
    public init(
        rows: [DPTableRowModel]
//        header: DPTableSectionHeaderModel? = nil,
//        footer: DPTableSectionHeaderModel? = nil
    ) {
        self.rows = rows
//        self.header = header
//        self.footer = footer
    }
    
}

public extension DPTableSectionModel {
    
    func getRow(at index: Int) -> DPTableRowModel? {
        guard self.rows.indices.contains(index) else { return nil }
        
        return self.rows[index]
    }
    
}

// MARK: - Array + DPTableSection
public extension Array where Element == DPTableSectionModel {
    
    var rowsCount: Int {
        self.reduce(0, { $0 + $1.rows.count })
    }
    
    var rowsIsEmpty: Bool {
        self.rowsCount == 0
    }
    
//    var headersIsEmpty: Bool {
//        self.filter({ $0.header != nil }).isEmpty
//    }
//
//    var footersIsEmpty: Bool {
//        self.filter({ $0.footer != nil }).isEmpty
//    }
    
    func getRow(at indexPath: IndexPath) -> DPTableRowModel? {
        guard self.indices.contains(indexPath.section) else { return nil }
        
        return self[indexPath.section].getRow(at: indexPath.row)
    }
    
}
