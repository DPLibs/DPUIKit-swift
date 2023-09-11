//
//  TableViewCellModelProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

public protocol TableViewCellModelProtocol {
    var cellClass: AnyClass { get }
    var cellHeight: CGFloat { get }
    var cellEstimatedHeight: CGFloat { get }
}

public extension TableViewCellModelProtocol {
    
    var cellHeight: CGFloat {
        TableConstants.cellHeight
    }
    
    var cellEstimatedHeight: CGFloat {
        TableConstants.cellEstimatedHeight
    }
    
}
