//
//  TableTypealiases.swift
//  Demo
//
//  Created by Дмитрий Поляков on 14.09.2023.
//

import Foundation
import UIKit

public typealias TableViewCellContext = (cell: UITableViewCell, model: Any, indexPath: IndexPath)
public typealias TableViewCellContextClosure = (TableViewCellContext) -> Void

public typealias TableViewHeaderFotterContext = (view: UITableViewHeaderFooterView, model: TableViewHeaderFooterModelProtocol, section: Int)
public typealias TableViewHeaderFotterContextClosure = (TableViewHeaderFotterContext) -> Void
