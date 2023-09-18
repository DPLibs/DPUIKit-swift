//
//  DPTableRowModel.swift
//  Demo
//
//  Created by Дмитрий Поляков on 18.09.2023.
//

import Foundation

open class DPTableRowModel<Cell: DPTableRowCellProtocol>: DPTableRowModelProtocol {
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Props
    open var cellClass: DPTableRowCellProtocol.Type = Cell.self
    open var cellHeight: CGFloat = DPTableConstants.Cell.heihgt
    open var cellEstimatedHeight: CGFloat = DPTableConstants.Cell.estimatedHeight
}
