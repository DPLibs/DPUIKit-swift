//
//  TableViewSection.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation

public struct TableViewSection: TableViewSectionProtocol {
    
    // MARK: - Init
    public init(
        rows: [TableViewCellModelProtocol] = [],
        header: TableViewHeaderFooterModelProtocol? = nil,
        footer: TableViewHeaderFooterModelProtocol? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }
    
    // MARK: - Props
    public var rows: [TableViewCellModelProtocol]
    public var header: TableViewHeaderFooterModelProtocol?
    public var footer: TableViewHeaderFooterModelProtocol?
}
