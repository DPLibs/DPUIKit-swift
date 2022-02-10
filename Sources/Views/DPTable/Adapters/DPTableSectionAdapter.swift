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
    open var rows: [DPTableRowModel]
    open var header: DPTableSectionHeaderModel?
    open var footer: DPTableSectionHeaderModel?
    
    open var didSelectRow: ((CellContext) -> Void)?
    open var didBottomAchived: ((CellContext) -> Void)?
    open var didScroll: ((ScrollContext) -> Void)?
    
    open internal(set) var lastContentOffset: CGPoint?
    
    // MARK: - Methods
    open func getRow(atIndexPath indexPath: IndexPath) -> DPTableRowModel? {
        self.rows.getRow(atIndexPath: indexPath)
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
            let model = self.getRow(atIndexPath: indexPath),
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

// MARK: - Array + DPTableSectionAdapter
public extension Array where Element == DPTableSectionAdapter {
    
    func getSection(atIndex index: Int) -> DPTableSectionAdapter? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
    
    func getSection(atIndexPath indexPath: IndexPath) -> DPTableSectionAdapter? {
        self.getSection(atIndex: indexPath.section)
    }
    
}
