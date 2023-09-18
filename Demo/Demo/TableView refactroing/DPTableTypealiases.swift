//
//  DPTableTypealizses.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public typealias DPTableConcrectCellContext<Cell: DPTableRowCellProtocol, Model: DPTableRowModelProtocol> = (cell: Cell, model: Model, indexPath: IndexPath)

public typealias DPTableCellContext = (cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
public typealias DPTableCellContextClosure = (DPTableCellContext) -> Void
public typealias DPTableCellContextToSwipeActionsConfiguration = (DPTableCellContext) -> UISwipeActionsConfiguration?
