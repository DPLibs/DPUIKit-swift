//
//  TableViewCellOutput.swift
//  Demo
//
//  Created by Дмитрий Поляков on 14.09.2023.
//

//import Foundation
//
//public struct TableViewCellOutput: TableViewCellOutputProtocol {
//    
//    // MARK: - Init
//    public init(
//        onCellForRow: TableViewCellContextClosure? = nil,
//        onWillDisplayRow: TableViewCellContextClosure? = nil,
//        didSelectRow: TableViewCellContextClosure? = nil,
//        didDeselectRow: TableViewCellContextClosure? = nil
//    ) {
//        self.onCellForRow = onCellForRow
//        self.onWillDisplayRow = onWillDisplayRow
//        self.didSelectRow = didSelectRow
//        self.didDeselectRow = didDeselectRow
//    }
//    
//    // MARK: - Props
//    public var onCellForRow: TableViewCellContextClosure?
//    public var onWillDisplayRow: TableViewCellContextClosure?
//    public var didSelectRow: TableViewCellContextClosure?
//    public var didDeselectRow: TableViewCellContextClosure?
//    
//    // MARK: - Methods
//    public func _sendOnCellForRow(_ context: TableViewCellContext) {
//        self.onCellForRow?(context)
//    }
//    
//    public func _sendOnWillDisplayRow(_ context: TableViewCellContext) {
//        self.onWillDisplayRow?(context)
//    }
//    
//    public func _sendDidSelectRow(_ context: TableViewCellContext) {
//        self.didSelectRow?(context)
//    }
//    
//    public func _sendDidDeselectRow(_ context: TableViewCellContext) {
//        self.didDeselectRow?(context)
//    }
//}
