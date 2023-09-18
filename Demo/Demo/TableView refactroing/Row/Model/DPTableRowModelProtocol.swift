//
//  DPTableRowModelProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public protocol DPTableRowModelProtocol {
    var cellClass: DPTableRowCellProtocol.Type { get }
    var cellHeight: CGFloat { get }
    var cellEstimatedHeight: CGFloat { get }
    
    var didSelect: DPTableCellContextClosure? { get }
    var didDeselect: DPTableCellContextClosure? { get }
    var onCell: DPTableCellContextClosure? { get }
    var willDisplay: DPTableCellContextClosure? { get }
    var willBeginEditing: DPTableCellContextClosure? { get }
    var didEndEditing: DPTableCellContextClosure? { get }
    var onCellLeading: DPTableCellContextToSwipeActionsConfiguration? { get }
    var onCellTrailing: DPTableCellContextToSwipeActionsConfiguration? { get }
}
 
// MARK: - Default
public extension DPTableRowModelProtocol {
    var cellHeight: CGFloat { DPTableConstants.Cell.heihgt }
    var cellEstimatedHeight: CGFloat { DPTableConstants.Cell.estimatedHeight }
    
    var didSelect: DPTableCellContextClosure? { nil }
    var didDeselect: DPTableCellContextClosure? { nil }
    var onCell: DPTableCellContextClosure? { nil }
    var willDisplay: DPTableCellContextClosure? { nil }
    var willBeginEditing: DPTableCellContextClosure? { nil }
    var didEndEditing: DPTableCellContextClosure? { nil }
    var onCellLeading: DPTableCellContextToSwipeActionsConfiguration? { nil }
    var onCellTrailing: DPTableCellContextToSwipeActionsConfiguration? { nil }
}
