//
//  TableViewSection.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation

public struct TableViewSection: TableViewSectionProtocol {
    public var models: [TableViewCellModelProtocol]
    public var header: TableViewHeaderFooterModelProtocol?
    public var fotter: TableViewHeaderFooterModelProtocol?
}
