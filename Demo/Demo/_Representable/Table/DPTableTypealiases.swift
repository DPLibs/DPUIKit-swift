//
//  DPTableTypealiases.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public typealias DPTableRowContext = (cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
public typealias DPTableRowContextClosure = (DPTableRowContext) -> Void
public typealias DPTableRowContextToSwipeActionsConfiguration = (DPTableRowContext) -> UISwipeActionsConfiguration?



