//
//  DPTableDataSourceSectionAdapter.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

public protocol DPTableSectionAdapterOutput: AnyObject {
    func didSelectRow(_ adapter: DPTableSectionAdapter, at indexPath: IndexPath, model: DPTableRowModel, cell: UITableViewCell)
    func bottomAchived(_ adapter: DPTableSectionAdapter, last indexPath: IndexPath)
}

open class DPTableSectionAdapter: NSObject, DPTableAdapterProtocol {
    
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
    open weak var output: DPTableSectionAdapterOutput?
    open var rows: [DPTableRowModel]
    open var header: DPTableSectionHeaderModel?
    open var footer: DPTableSectionHeaderModel?
    
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

#warning("Dev.Append to extensions")
extension UITableView {
    
    func getLastIndexPath() -> IndexPath? {
        guard let numberOfSections = self.dataSource?.numberOfSections?(in: self), numberOfSections > 0 else { return nil }
        let section = numberOfSections - 1
        
        guard let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section), numberOfRows > 0 else { return nil }
        let row = numberOfRows - 1
        
        return .init(row: row, section: section)
    }
    
}

// MARK: - UITableViewDelegate
extension DPTableSectionAdapter: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let lastIndexPath = tableView.getLastIndexPath(), lastIndexPath == indexPath else { return }
        self.output?.bottomAchived(self, last: lastIndexPath)
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
            let cell = tableView.cellForRow(at: indexPath)
        else { return }
        
        self.output?.didSelectRow(self, at: indexPath, model: model, cell: cell)
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

//    // MARK: - UITableViewDelegate + Row
//    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        guard let tableView = self.tableView else { return }
//
//        tableView.cellsOutput?.willDisplayRow(tableView, indexPath: indexPath, cell: cell)
//
//        let offsetToTop = self.calculateRowsCountOrLess(at: indexPath)
//        tableView.dataOutput?.scrollToPosition(tableView, position: .top, rowsOffset: offsetToTop)
//
//        if offsetToTop == 0 {
//            tableView.dataOutput?.topAchived(tableView)
//        }
//
//        let offsetToBottom = self.sections.rowsCount - offsetToTop
//        tableView.dataOutput?.scrollToPosition(tableView, position: .bottom, rowsOffset: offsetToBottom)
//
//        if offsetToBottom == 0 {
//            tableView.dataOutput?.bottomAchived(tableView)
//        }
//    }

//
//    // MARK: - UITableViewDelegate + Scroll
//    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset
//
//        if self.lastContentOffset == nil {
//            self.lastContentOffset = offset
//        }
//
//        guard
//            let lastOffset = self.lastContentOffset,
//            let tableView = self.tableView
//        else { return }
//
//        let scrollToPosition: UITableView.ScrollPosition = lastOffset.y > offset.y ? .top : .bottom
//        let bottomOffset = tableView.calculateBottomOffset()
//        let isDragging = scrollView.isDragging
//
//        tableView.scrollOutput?.didScroll(tableView, to: scrollToPosition, isDragging: isDragging)
//
//        guard isDragging else { return }
//
//        switch scrollToPosition {
//        case .top:
//            let pointForCell = CGPoint(x: offset.x, y: offset.y < 0 ? 0 : offset.y)
//
//            if let indexPathForCell = tableView.indexPathForRow(at: pointForCell) {
//                let offsetToTop = self.calculateRowsCountOrLess(at: indexPathForCell)
//                tableView.dataOutput?.scrollToPosition(tableView, position: .top, rowsOffset: offsetToTop)
//            }
//        case .bottom:
//            let pointForCell = CGPoint(x: offset.x, y: offset.y + tableView.frame.height)
//
//            if let indexPathForCell = tableView.indexPathForRow(at: pointForCell) {
//                let offsetToBottom = self.sections.rowsCount - self.calculateRowsCountOrLess(at: indexPathForCell)
//                tableView.dataOutput?.scrollToPosition(tableView, position: .bottom, rowsOffset: offsetToBottom)
//            }
//        default:
//            break
//        }
//
//        let topAchived = offset.y <= -scrollView.contentInset.top
//        let bottomAchived = offset.y >= (bottomOffset.y < 0 ? 0 : bottomOffset.y)
//
//        tableView.scrollOutput?.scrollPositionAchived(tableView, position: .top, isAchived: topAchived)
//        tableView.scrollOutput?.scrollPositionAchived(tableView, position: .bottom, isAchived: bottomAchived)
//
//        self.lastContentOffset = offset
//    }
//

//
//    // MARK: - UITableViewDelegate + Swipe
//    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard
//            let model = self.sections.getRow(at: indexPath),
//            let cell = tableView.cellForRow(at: indexPath)
//        else {
//            return .empty
//        }
//
//        return model.createLeadingSwipeActionsConfiguration(for: cell)
//    }
//
//    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        guard
//            let model = self.sections.getRow(at: indexPath),
//            let cell = tableView.cellForRow(at: indexPath)
//        else {
//            return .empty
//        }
//
//        return model.createTrailingSwipeActionsConfiguration(for: cell)
//    }
//
//    // MARK: - UITableViewDelegate + Edit
//    open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//        guard
//            let model = self.sections.getRow(at: indexPath),
//            let cell = tableView.cellForRow(at: indexPath)
//        else { return }
//
//        return model.willBeginEditing(for: cell)
//    }
//
//    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        guard
//            let indexPath = indexPath,
//            let model = self.sections.getRow(at: indexPath),
//            let cell = tableView.cellForRow(at: indexPath)
//        else { return }
//
//        return model.didEndEditing(for: cell)
//    }
//
//}
