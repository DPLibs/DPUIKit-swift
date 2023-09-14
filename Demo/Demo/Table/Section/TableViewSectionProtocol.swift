//
//  TableViewSectionProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation

public protocol TableViewSectionProtocol {
    var models: [TableViewCellModelProtocol] { get set }
    var header: TableViewHeaderFooterModelProtocol? { get set }
    var footer: TableViewHeaderFooterModelProtocol? { get set }
}
