//
//  DPTableDataSourceSectionAdapter.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableSectionAdapter: NSObject {
    
    public typealias CellContext = (indexPath: IndexPath, cell: DPTableViewCell, model: DPTableRowModel)
    public typealias ScrollContext = (offset: CGPoint, direction: UITableView.ScrollPosition, isDragging: Bool)
    
    // MARK: - Init
    public init(
        rows: [DPTableRowModel] = [],
        header: DPTableSectionHeaderModel? = nil,
        footer: DPTableSectionHeaderModel? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }
    
    // MARK: - Props
    internal weak var tableView: UITableView?
    internal weak var parent: DPTableAdapter?
    
    open var rows: [DPTableRowModel]
    open var header: DPTableSectionHeaderModel?
    open var footer: DPTableSectionHeaderModel?
    
    open var didSelectRow: ((CellContext) -> Void)?
    open var didBottomAchived: ((CellContext) -> Void)?
    open var didScroll: ((ScrollContext) -> Void)?
    
    open private(set) var lastContentOffset: CGPoint?
    
    public var sectionIndex: Int {
        self.parent?.sections.firstIndex(of: self) ?? .zero
    }
    
    // MARK: - Methods
    open func getRow(at indexPath: IndexPath) -> DPTableRowModel? {
        self.rows.getRow(atIndexPath: indexPath)
    }
    
    open func setupTable(_ tableView: UITableView) {
        self.tableView = tableView
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
    }
    
}

// MARK: - UITableViewDataSource
extension DPTableSectionAdapter: UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.rows.getRow(atIndexPath: indexPath), let cellClass = model.cellClass else { return .init() }
        tableView.registerCellClasses([ cellClass ])
        
        guard
            let cellIdentifier = model.cellIdentifier,
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DPTableViewCell
        else { return .init() }

        cell._model = model
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension DPTableSectionAdapter: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            let lastIndexPath = tableView.getLastIndexPath(),
            lastIndexPath == indexPath,
            let model = self.getRow(at: indexPath),
            let cell = cell as? DPTableViewCell
        else { return }
        
        self.didBottomAchived?((indexPath, cell, model))
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.rows.getRow(atIndexPath: indexPath)?.rowHeight ?? tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        self.rows.getRow(atIndexPath: indexPath)?.estimatedRowHeight ?? tableView.estimatedRowHeight
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let model = self.rows.getRow(atIndexPath: indexPath),
            let cell = tableView.cellForRow(at: indexPath) as? DPTableViewCell
        else { return }
        
        self.didSelectRow?((indexPath, cell, model))
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = self.header, let viewClass = model.viewClass else { return nil }
        tableView.registerHeaderFooterViewClasses([ viewClass ])
        
        guard
            let viewIdentifier = model.viewIdentifier,
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier) as? DPTableViewHeaderFooterView
        else { return nil }
        
        view._model = model
        return view
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.header?.viewHeight ?? tableView.sectionHeaderHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        self.header?.viewEstimatedHeight ?? tableView.estimatedSectionHeaderHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let model = self.footer, let viewClass = model.viewClass else { return nil }
        tableView.registerHeaderFooterViewClasses([ viewClass ])
        
        guard
            let viewIdentifier = model.viewIdentifier,
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier) as? DPTableViewHeaderFooterView
        else { return nil }
        
        view._model = model
        return view
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.footer?.viewHeight ?? tableView.sectionHeaderHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        self.footer?.viewEstimatedHeight ?? tableView.estimatedSectionHeaderHeight
    }
    
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset

        if self.lastContentOffset == nil {
            self.lastContentOffset = offset
        }

        guard let lastOffset = self.lastContentOffset else { return }
        let direction: UITableView.ScrollPosition = lastOffset.y > offset.y ? .top : .bottom
        let isDragging = scrollView.isDragging
        
        self.didScroll?((offset, direction, isDragging))
    }
    
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let model = self.rows.getRow(atIndexPath: indexPath),
            let cell = tableView.cellForRow(at: indexPath)
        else {
            return .empty
        }

        return model.leadingSwipeActionsConfiguration(for: cell)
    }

    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let model = self.rows.getRow(atIndexPath: indexPath),
            let cell = tableView.cellForRow(at: indexPath)
        else {
            return .empty
        }

        return model.trailingSwipeActionsConfiguration(for: cell)
    }

    open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        guard
            let model = self.rows.getRow(atIndexPath: indexPath),
            let cell = tableView.cellForRow(at: indexPath)
        else { return }

        return model.willBeginEditing(for: cell)
    }

    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard
            let indexPath = indexPath,
            let model = self.rows.getRow(atIndexPath: indexPath),
            let cell = tableView.cellForRow(at: indexPath)
        else { return }

        return model.didEndEditing(for: cell)
    }
    
}

// MARK: - Update
public extension DPTableSectionAdapter {
    
    struct Update {
        public typealias PerformContext = (adapter: DPTableSectionAdapter, tableView: UITableView)
        public let perform: (PerformContext) -> Void
    }

    func performUpdates(updates: [Update]? = nil, completion: ((Bool) -> Void)? = nil) {
        guard let tableView = self.tableView else {
            print("[DPTableSectionAdapter] - [performUpdates] - error: TableView not implemented")
            completion?(false)
            return
        }
        
        tableView.performBatchUpdates({ [weak self] in
            guard let self = self else { return }

            (updates ?? []).forEach({ $0.perform((self, tableView)) })
        }, completion: completion)
    }
    
}

// MARK: - Rows + Edit
extension DPTableSectionAdapter {
    
    @discardableResult
    open func insertRows(_ rows: [DPTableRowModel], at indices: [Int]) -> [IndexPath] {
        let indexPaths = indices.map({ IndexPath(row: $0, section: self.sectionIndex) })
        
        for (offset, indexPath) in indexPaths.enumerated() {
            let row = rows[offset]
            self.rows.insert(row, at: indexPath.row)
        }
        
        return indexPaths
    }
    
    @discardableResult
    open func appendRows(_ rows: [DPTableRowModel]) -> [IndexPath] {
        let countBeforeAppend = self.rows.count
        let indexPaths = rows.indices.map({ IndexPath(row: $0 + countBeforeAppend, section: self.sectionIndex) })

        for (offset, indexPath) in indexPaths.enumerated() {
            let row = rows[offset]
            self.rows.insert(row, at: indexPath.row)
        }
        
        return indexPaths
    }

    @discardableResult
    open func setRows(_ rows: [DPTableRowModel], at indices: [Int]) -> [IndexPath] {
        let indexPaths = indices.map({ IndexPath(row: $0, section: self.sectionIndex) })
        
        for (offset, indexPath) in indexPaths.enumerated() {
            let row = rows[offset]
            self.rows[indexPath.row] = row
        }
        
        return indexPaths
    }

    @discardableResult
    open func deleteRows(at indices: [Int]) -> [IndexPath] {
        let indexPaths = indices.map({ IndexPath(row: $0, section: self.sectionIndex) })
        
        for indexPath in indexPaths {
            self.rows.remove(at: indexPath.row)
        }
        
        return indexPaths
    }
    
}

// MARK: - DPTableSectionAdapter.Update + Store
public extension DPTableSectionAdapter.Update {

    static func insertRows(
        _ rows: [DPTableRowModel],
        at indices: [Int],
        with rowAnimation: UITableView.RowAnimation = .automatic
    ) -> Self {
        .init { (adapter, tableView) in
            let indexPaths = adapter.insertRows(rows, at: indices)
            tableView.insertRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    static func appendRows(
        _ rows: [DPTableRowModel],
        with rowAnimation: UITableView.RowAnimation = .automatic
    ) -> Self {
        .init { (adapter, tableView) in
            let indexPaths = adapter.appendRows(rows)
            tableView.insertRows(at: indexPaths, with: rowAnimation)
        }
    }

    static func setRows(
        _ rows: [DPTableRowModel],
        at indices: [Int],
        with rowAnimation: UITableView.RowAnimation = .automatic
    ) -> Self {
        .init { (adapter, tableView) in
            let indexPaths = adapter.setRows(rows, at: indices)
            tableView.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }

    static func deleteRows(
        at indices: [Int],
        with rowAnimation: UITableView.RowAnimation = .automatic
    ) -> Self {
        .init { (adapter, tableView) in
            let indexPaths = adapter.deleteRows(at: indices)
            tableView.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    static func reloadRows(
        at indices: [Int],
        with rowAnimation: UITableView.RowAnimation = .automatic
    ) -> Self {
        .init { (adapter, tableView) in
            let indexPaths = indices.map({ IndexPath(row: $0, section: adapter.sectionIndex) })
            tableView.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }

}

// MARK: - Array + DPTableSectionAdapter
public extension Array where Element == DPTableSectionAdapter {
    
    func getSection(atIndex index: Int) -> DPTableSectionAdapter? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
    
    func getSection(at indexPath: IndexPath) -> DPTableSectionAdapter? {
        self.getSection(atIndex: indexPath.section)
    }
    
}
