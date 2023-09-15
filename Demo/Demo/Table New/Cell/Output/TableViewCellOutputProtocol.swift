//
//  TableViewCellOutputProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 14.09.2023.
//

import Foundation

public protocol TableViewCellOutputProtocol {
    func _sendOnCellForRow(_ context: TableViewCellContext)
    func _sendOnWillDisplayRow(_ context: TableViewCellContext)
    func _sendDidSelectRow(_ context: TableViewCellContext)
    func _sendDidDeselectRow(_ context: TableViewCellContext)
}
