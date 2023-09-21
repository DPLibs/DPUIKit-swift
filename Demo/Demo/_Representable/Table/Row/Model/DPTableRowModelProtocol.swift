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
    var cellHeight: CGFloat? { get }
    var cellEstimatedHeight: CGFloat? { get }
    
    var didSelect: DPTableRowContextClosure? { get }
    var didDeselect: DPTableRowContextClosure? { get }
    var onCell: DPTableRowContextClosure? { get }
    var willDisplay: DPTableRowContextClosure? { get }
    var willBeginEditing: DPTableRowContextClosure? { get }
    var didEndEditing: DPTableRowContextClosure? { get }
    var onCellLeading: DPTableRowContextToSwipeActionsConfiguration? { get }
    var onCellTrailing: DPTableRowContextToSwipeActionsConfiguration? { get }
}
 
// MARK: - Default
public extension DPTableRowModelProtocol {
    var cellHeight: CGFloat? { nil }
    var cellEstimatedHeight: CGFloat? { nil }
    
    var didSelect: DPTableRowContextClosure? { nil }
    var didDeselect: DPTableRowContextClosure? { nil }
    var onCell: DPTableRowContextClosure? { nil }
    var willDisplay: DPTableRowContextClosure? { nil }
    var willBeginEditing: DPTableRowContextClosure? { nil }
    var didEndEditing: DPTableRowContextClosure? { nil }
    var onCellLeading: DPTableRowContextToSwipeActionsConfiguration? { nil }
    var onCellTrailing: DPTableRowContextToSwipeActionsConfiguration? { nil }
}
