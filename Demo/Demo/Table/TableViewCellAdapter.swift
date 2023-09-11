//
//  TableViewCellAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

open class TableViewCellAdapter<Cell: TableViewCell>: TableViewCellModelProtocol {

    open var cellClass: AnyClass {
        Cell.self
    }
}
