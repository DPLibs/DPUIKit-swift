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
        models: [TableViewCellModelProtocol] = [],
        header: TableViewHeaderFooterModelProtocol? = nil,
        footer: TableViewHeaderFooterModelProtocol? = nil
    ) {
        self.models = models
        self.header = header
        self.footer = footer
    }
    
    // MARK: - Props
    public var models: [TableViewCellModelProtocol]
    public var header: TableViewHeaderFooterModelProtocol?
    public var footer: TableViewHeaderFooterModelProtocol?
}
