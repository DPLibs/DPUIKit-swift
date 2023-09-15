//
//  DPTableViewCellModelProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public protocol DPTableViewCellModelProtocol {
    var cellClass: DPTableViewCellProtocol.Type { get }
    var equalIdentifier: String { get }
    var cellHeight: CGFloat { get }
    var cellEstimatedHeight: CGFloat { get }
    
    var didSelectRow: DPTableCellContextClosure? { get }
    var didDeselectRow: DPTableCellContextClosure? { get }
    var onCellForRow: DPTableCellContextClosure? { get }
    var willDisplayRow: DPTableCellContextClosure? { get }
    var willBeginEditingRow: DPTableCellContextClosure? { get }
    var didEndEditingRow: DPTableCellContextClosure? { get }
    
    var onCellLeading: ((DPTableCellContext) -> UISwipeActionsConfiguration?)? { get }
    var onCellTrailing: ((DPTableCellContext) -> UISwipeActionsConfiguration?)? { get }
}
 
// MARK: - Default
public extension DPTableViewCellModelProtocol {
    var equalIdentifier: String { "" }
    var cellHeight: CGFloat { DPTableConstants.Cell.heihgt }
    var cellEstimatedHeight: CGFloat { DPTableConstants.Cell.estimatedHeight }
    
    var didSelectRow: DPTableCellContextClosure? { nil }
    var didDeselectRow: DPTableCellContextClosure? { nil }
    var onCellForRow: DPTableCellContextClosure? { nil }
    var willDisplayRow: DPTableCellContextClosure? { nil }
    var willBeginEditingRow: DPTableCellContextClosure? { nil }
    var didEndEditingRow: DPTableCellContextClosure? { nil }
    
    var onCellLeading: ((DPTableCellContext) -> UISwipeActionsConfiguration?)? {
        { _ in .empty }
    }
    
    var onCellTrailing: ((DPTableCellContext) -> UISwipeActionsConfiguration?)? {
        { _ in .empty }
    }
}
