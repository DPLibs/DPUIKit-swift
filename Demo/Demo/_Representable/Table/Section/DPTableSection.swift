//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

public struct DPTableSection: DPTableSectionProtocol {
    
    // MARK: - Init
    public init(
        rows: [DPTableRowModelProtocol] = [],
        header: DPTableViewHeaderFooterViewModelProtocol? = nil,
        footer: DPTableViewHeaderFooterViewModelProtocol? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }

    // MARK: - Props
    public var rows: [DPTableRowModelProtocol]
    public var header: DPTableViewHeaderFooterViewModelProtocol?
    public var footer: DPTableViewHeaderFooterViewModelProtocol?
}
