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
    var output: DPTableRowOutputProtocol? { get }
}
 
// MARK: - Default
public extension DPTableRowModelProtocol {
    var cellHeight: CGFloat { DPTableConstants.Cell.heihgt }
    var cellEstimatedHeight: CGFloat { DPTableConstants.Cell.estimatedHeight }
    var output: DPTableRowOutputProtocol? { nil }
}
