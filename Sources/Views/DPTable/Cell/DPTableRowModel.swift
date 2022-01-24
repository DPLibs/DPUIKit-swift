//
//  DPTableRowModel.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableRowModel {
    
    // MARK: - Props
    open var cellIdentifier: String? {
//        nil
        guard let cellClass = self.cellClass else { return nil }
        return String(describing: cellClass.self)
    }
    
    open var cellClass: AnyClass? {
        nil
    }

    open var rowHeight: CGFloat {
        UITableView.automaticDimension
    }
    
    open var estimatedRowHeight: CGFloat {
        50
    }
    
    public var didTap: (() -> Void)?

    // MARK: - Init
    public init(didTap: (() -> Void)? = nil) {
        self.didTap = didTap
    }
    
    // MARK: - Methods
    open func createLeadingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? {
        .empty
    }
    
    open func createTrailingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? {
        .empty
    }
    
    open func willBeginEditing(for cell: UITableViewCell) { }
    
    open func didEndEditing(for cell: UITableViewCell) { }
    
}

// MARK: - Array + DPTableRowModel
extension Array where Element == DPTableRowModel {
    
    func getRow(atIndexPath indexPath: IndexPath) -> DPTableRowModel? {
        guard self.indices.contains(indexPath.row) else { return nil }
        return self[indexPath.row]
    }
    
}
