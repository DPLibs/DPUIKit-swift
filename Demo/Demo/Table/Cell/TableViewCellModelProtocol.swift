//
//  TableViewCellModelProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

public protocol TableViewCellModelProtocol {
    var id: TableUUID { get }
    var cellClass: AnyClass { get }
    var cellHeight: CGFloat { get }
    var cellEstimatedHeight: CGFloat { get }
    var cellAdapter: TableViewCellAdapterProtocol? { get }
}

public extension TableViewCellModelProtocol {
    
    var cellHeight: CGFloat {
        TableConstants.cellHeight
    }
    
    var cellEstimatedHeight: CGFloat {
        TableConstants.cellEstimatedHeight
    }
    
    var cellAdapter: TableViewCellAdapterProtocol? {
        nil
    }
    
}

public protocol TableViewCellAdapterProtocol {
    var onCellForRow: TableViewCellContextClosure? { get }
    var onWillDisplayRow: TableViewCellContextClosure? { get }
    var didSelectRow: TableViewCellContextClosure? { get }
    var didDeselectRow: TableViewCellContextClosure? { get }
}

public struct TableViewCellAdapter: TableViewCellAdapterProtocol {
    
    // MARK: - Init
    public init(
        onCellForRow: TableViewCellContextClosure? = nil,
        onWillDisplayRow: TableViewCellContextClosure? = nil,
        didSelectRow: TableViewCellContextClosure? = nil,
        didDeselectRow: TableViewCellContextClosure? = nil
    ) {
        self.onCellForRow = onCellForRow
        self.onWillDisplayRow = onWillDisplayRow
        self.didSelectRow = didSelectRow
        self.didDeselectRow = didDeselectRow
    }
    
    // MARK: - Props
    public var onCellForRow: TableViewCellContextClosure?
    public var onWillDisplayRow: TableViewCellContextClosure?
    public var didSelectRow: TableViewCellContextClosure?
    public var didDeselectRow: TableViewCellContextClosure?
}
