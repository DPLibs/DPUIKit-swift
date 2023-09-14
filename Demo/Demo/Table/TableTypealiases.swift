//
//  TableTypealiases.swift
//  Demo
//
//  Created by Дмитрий Поляков on 14.09.2023.
//

import Foundation
import UIKit

public typealias TableViewCellContext = (cell: UITableViewCell, model: TableViewCellModelProtocol, indexPath: IndexPath)
public typealias TableViewCellContextClosure = (TableViewCellContext) -> Void

public typealias TableViewHeaderFotterContext = (view: UITableViewHeaderFooterView, model: TableViewHeaderFooterModelProtocol, section: Int)
public typealias TableViewHeaderFotterContextClosure = (TableViewHeaderFotterContext) -> Void


public typealias TableUUID = String

public extension TableUUID {
    
    static func int(_ value: Int) -> TableUUID {
        value.description
    }
    
    static func uuid(_ value: UUID = UUID()) -> TableUUID {
        value.uuidString
    }
    
}
