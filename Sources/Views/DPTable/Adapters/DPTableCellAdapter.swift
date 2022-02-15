//
//  DPTableCellAdapter.swift
//  
//
//  Created by Дмитрий Поляков on 15.02.2022.
//

import Foundation
import UIKit

public typealias DPTableCellContext = (indexPath: IndexPath, cell: DPTableViewCell, model: DPTableRowModel)

open class DPTableCellAdapter<CellType: UITableViewCell> {
    
    // MARK: - Props
    open var cellClass: AnyClass {
        CellType.self
    }
    
    open var cellIdentifier: String {
        String(describing: cellClass.self)
    }
    
    open var rowHeight: CGFloat {
        UITableView.automaticDimension
    }
    
    open var estimatedRowHeight: CGFloat {
        50
    }
    
    open var didCellForRow: ((DPTableCellContext) -> Void)?
    open var willDisplay: ((DPTableCellContext) -> Void)?
    
    internal weak var cell: UITableViewCell?
    internal weak var sectionAdapter: DPTableSectionAdapter?
    
    // MARK: - Methods
    open func leadingSwipeActionsConfiguration(for context: DPTableCellContext) -> UISwipeActionsConfiguration? {
        .empty
    }
    
    open func trailingSwipeActionsConfiguration(for context: DPTableCellContext) -> UISwipeActionsConfiguration? {
        .empty
    }
    
    open func willBeginEditing(for cell: UITableViewCell) { }
    
    open func didEndEditing(for cell: UITableViewCell) { }
    
}
