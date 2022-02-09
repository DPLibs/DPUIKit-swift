//
//  DPTableDataSourceSectionAdapter.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableSectionAdapter: NSObject {
    
    public typealias CellContext = (IndexPath, DPTableViewCell, DPTableRowModel)
    
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
