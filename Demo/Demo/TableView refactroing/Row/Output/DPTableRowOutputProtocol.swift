//
//  DPTableRowOutputProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 18.09.2023.
//

import Foundation
import UIKit

public protocol DPTableRowOutputProtocol {
    var didSelect: DPTableCellContextClosure? { get }
    var didDeselect: DPTableCellContextClosure? { get }
    var onCell: DPTableCellContextClosure? { get }
    var willDisplay: DPTableCellContextClosure? { get }
    var willBeginEditing: DPTableCellContextClosure? { get }
    var didEndEditing: DPTableCellContextClosure? { get }
    var onCellLeading: DPTableCellContextToSwipeActionsConfiguration? { get }
    var onCellTrailing: DPTableCellContextToSwipeActionsConfiguration? { get }
}
