//
//  DPTableView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

// MARK: - View
open class DPTableView: UITableView, DPTableViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)

        self.commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.commonInit()
    }

    // MARK: - Props
    open override var refreshControl: UIRefreshControl? {
        didSet {
            self.refreshControlDidSet()
        }
    }

//    open override var tableHeaderView: UIView? {
//        didSet {
//            self.didSetRefreshControl()
//        }
//    }
//
//    open weak var dataOutput: DPTableDataOutput?
//
//    open weak var cellsOutput: DPTableCellsOutput?
//
//    open weak var scrollOutput: DPTableScrollOutput?
//
//    open var sections: [DPTableSectionModel] = [] {
//        didSet {
//            self.updatePlaceholderViewAutoHidden()
//        }
//    }
//
//    open var placeholderView: DPView? {
//        didSet {
//            oldValue?.removeFromSuperview()
//            self.backgroundView = self.placeholderView
//        }
//    }
//
//    open var placeholderViewAutoHiddenEnabled: Bool = true

    // MARK: - Methods
    open func refreshControlDidSet() {
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

    // MARK: - DPTableViewProtocol
    open func commonInit() {
        self.setupComponents()
    }
    
    open func setupComponents() {}

    open func updateComponents() {}

    open func setHidden(_ hidden: Bool, animated: Bool) {}

    @objc
    open func tapButtonAction(_ button: UIButton) {}

    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
    open var isRefreshing: Bool {
        self.refreshControl?.isRefreshing ?? false
    }
    
    open func beginRefreshing() {
        self.refreshControl?.beginRefreshing()
    }
    
    open func endRefreshing() {
        self.refreshControl?.endRefreshing()
    }

}

//// MARK: - Data Output
//public protocol DPTableDataOutput: AnyObject {
//    func beginRefreshing(_ tableView: DPTableView)
//    func endRefreshing(_ tableView: DPTableView)
//    func selectRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell, row: DPTableRowModel)
//    func scrollToPosition(_ tableView: DPTableView, position: UITableView.ScrollPosition, rowsOffset: Int)
//    func topAchived(_ tableView: DPTableView)
//    func bottomAchived(_ tableView: DPTableView)
//}
//// MARK: - Cells Output
//public protocol DPTableCellsOutput: AnyObject {
//    func cellForRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell)
//    func willDisplayRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell)
//}
//// MARK: - Scroll Output
//public protocol DPTableScrollOutput: AnyObject {
//    func didScroll(_ tableView: DPTableView, to position: UITableView.ScrollPosition, isDragging: Bool)
//    func scrollPositionAchived(_ tableView: DPTableView, position: UITableView.ScrollPosition, isAchived: Bool)
//}
//// MARK: - View
//open class DPTableView: UITableView, DPViewProtocol {
//
//    // MARK: - Props
//    open override var refreshControl: UIRefreshControl? {
//        didSet {
//            self.didSetRefreshControl()
//        }
//    }
//
//    open override var tableHeaderView: UIView? {
//        didSet {
//            self.didSetRefreshControl()
//        }
//    }
//
//    open weak var dataOutput: DPTableDataOutput?
//
//    open weak var cellsOutput: DPTableCellsOutput?
//
//    open weak var scrollOutput: DPTableScrollOutput?
//
//    open var dataSourceAdapter: DPTableDataSourceAdapter? {
//        didSet {
//            self.didSetDataSourceAdapter()
//        }
//    }
//
//    open var delegateAdapter: DPTableDelegateAdapter? {
//        didSet {
//            self.didSetDelegateAdapter()
//        }
//    }
//
//    open var sections: [DPTableSectionModel] = [] {
//        didSet {
//            self.updatePlaceholderViewAutoHidden()
//        }
//    }
//
//    open var placeholderView: DPView? {
//        didSet {
//            oldValue?.removeFromSuperview()
//            self.backgroundView = self.placeholderView
//        }
//    }
//
//    open var placeholderViewAutoHiddenEnabled: Bool = true
//
//    // MARK: - Init
//    public override init(frame: CGRect, style: UITableView.Style) {
//        super.init(frame: frame, style: style)
//
//        self.setupComponents()
//    }
//
//    public required init?(coder: NSCoder) {
//        super.init(coder: coder)
//
//        self.setupComponents()
//    }
//
//    // MARK: - Methods
//    open func didSetDataSourceAdapter() {
//        self.dataSourceAdapter?.tableView = self
//    }
//
//    open func didSetDelegateAdapter() {
//        self.delegateAdapter?.tableView = self
//    }
//
//    open func didSetRefreshControl() {
//        guard let refreshControl = self.refreshControl else { return }
//
//        refreshControl.addTarget(self, action: #selector(self.refreshControlValueChanged(_:)), for: .valueChanged)
//        self.bringSubviewToFront(refreshControl)
//    }
//
//    @objc
//    open func refreshControlValueChanged(_ refreshControl: UIRefreshControl) {
//        self.dataOutput?.beginRefreshing(self)
//    }
//
//    open func beginRefreshing() {
//        self.refreshControl?.sendActions(for: .valueChanged)
//        self.reloadData()
//    }
//
//    open func endRefreshing() {
//        self.refreshControl?.endRefreshing()
//        self.dataOutput?.endRefreshing(self)
//    }
//
//    open func updatePlaceholderViewAutoHidden() {
//        guard self.placeholderViewAutoHiddenEnabled else { return }
//
//        var isEmpty: Bool {
//            self.sections.rowsIsEmpty && self.sections.headersIsEmpty && self.sections.footersIsEmpty
//        }
//
//        self.placeholderView?.setHidden(!isEmpty, animated: true)
//    }
//
//    open func reloadData(with sections: [DPTableSectionModel]) {
//        self.sections = sections
//        self.reloadData()
//    }
//
//    // MARK: - DPViewProtocol
//    open func setupComponents() {
//        self.delegateAdapter = .init()
//        self.dataSourceAdapter = .init()
//    }
//
//    open func updateComponents() {}
//
//    open func setHidden(_ hidden: Bool, animated: Bool) {}
//
//    @objc
//    open func tapButtonAction(_ button: UIButton) {}
//
//    @objc
//    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
//
//}
