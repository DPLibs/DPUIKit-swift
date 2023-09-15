//
//  TableViewHeaderFooterModelProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

public protocol TableViewHeaderFooterModelProtocol {
    var viewClass: AnyClass { get }
    var viewHeight: CGFloat { get }
    var viewEstimatedHeight: CGFloat { get }
}

public extension TableViewHeaderFooterModelProtocol {
    
    var viewHeight: CGFloat {
        TableConstants.headerFooterHeight
    }
    
    var viewEstimatedHeight: CGFloat {
        TableConstants.headerFooterEstimatedHeight
    }
    
}
