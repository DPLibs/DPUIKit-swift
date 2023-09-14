//
//  DPTableView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

// MARK: - Data Output
public protocol DPTableDataOutput: AnyObject {
    func selectRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell, row: DPTableRowModel)
    func scrollToPosition(_ tableView: DPTableView, position: UITableView.ScrollPosition, rowsOffset: Int)
    func topAchived(_ tableView: DPTableView)
    func bottomAchived(_ tableView: DPTableView)
}

public extension DPTableDataOutput {
    func selectRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell, row: DPTableRowModel) {}
    func scrollToPosition(_ tableView: DPTableView, position: UITableView.ScrollPosition, rowsOffset: Int) {}
    func topAchived(_ tableView: DPTableView) {}
    func bottomAchived(_ tableView: DPTableView) {}
}

// MARK: - Cells Output
public protocol DPTableCellsOutput: AnyObject {
    func cellForRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell)
    func willDisplayRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell)
}

public extension DPTableCellsOutput {
    func cellForRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell) {}
    func willDisplayRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell) {}
}

// MARK: - Scroll Output
public protocol DPTableScrollOutput: AnyObject {
    func didScroll(_ tableView: DPTableView, to position: UITableView.ScrollPosition, isDragging: Bool)
    func scrollPositionAchived(_ tableView: DPTableView, position: UITableView.ScrollPosition, isAchived: Bool)
}

public extension DPTableScrollOutput {
    func didScroll(_ tableView: DPTableView, to position: UITableView.ScrollPosition, isDragging: Bool) {}
    func scrollPositionAchived(_ tableView: DPTableView, position: UITableView.ScrollPosition, isAchived: Bool) {}
}

// MARK: - View
open class DPTableView: UITableView, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupComponents()
    }
    
    // MARK: - Props
    open override var refreshControl: UIRefreshControl? {
        didSet {
            self.didSetRefreshControl()
        }
    }
    
    open override var tableHeaderView: UIView? {
        didSet {
            self.didSetRefreshControl()
        }
    }
    
    open weak var dataOutput: DPTableDataOutput?
    open weak var cellsOutput: DPTableCellsOutput?
    open weak var scrollOutput: DPTableScrollOutput?
    
//    open var dataSourceAdapter: DPTableDataSourceAdapter? {
//        didSet {
//            self.didSetDataSourceAdapter()
//        }
//    }
    
    open var delegateAdapter: DPTableDelegateAdapter? {
        didSet {
            self.didSetDelegateAdapter()
        }
    }
    
    open var sections: [DPTableSectionModel] = [] {
        didSet {
//            self.updatePlaceholderViewAutoHidden()
        }
    }
    
    open var placeholderView: DPView? {
        didSet {
            oldValue?.removeFromSuperview()
            self.backgroundView = self.placeholderView
        }
    }
    
    open var placeholderViewAutoHiddenEnabled: Bool = true
    
    // MARK: - Methods
//    open func didSetDataSourceAdapter() {
//        self.dataSourceAdapter?.tableView = self
//    }
    
    open func didSetDelegateAdapter() {
        self.delegateAdapter?.tableView = self
    }
    
    open func didSetRefreshControl() {
        guard let refreshControl = self.refreshControl else { return }
        self.bringSubviewToFront(refreshControl)
    }
    
//    open func updatePlaceholderViewAutoHidden() {
//        guard self.placeholderViewAutoHiddenEnabled else { return }
//
//        var isEmpty: Bool {
//            self.sections.rowsIsEmpty && self.sections.headersIsEmpty && self.sections.footersIsEmpty
//        }
//
//        self.placeholderView?.setHidden(!isEmpty, animated: true)
//    }
    
    open func reloadData(with sections: [DPTableSectionModel]) {
        self.sections = sections
        self.reloadData()
    }
    
    // MARK: - DPViewProtocol
    open func setupComponents() {
        self.delegateAdapter = .init()
//        self.dataSourceAdapter = .init()
    }
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
}
