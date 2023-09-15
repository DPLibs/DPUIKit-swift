//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

//import Foundation
//import UIKit
//
//open class DPTableDelegateAdapter: NSObject, UITableViewDelegate {
//    
//    // MARK: - Props
//    open weak var tableView: DPTableView? {
//        didSet { self.tableView?.delegate = self }
//    }
//    
//    open var sections: [DPTableSection] {
//        get { self.tableView?.sections ?? [] }
//        set { self.tableView?.sections = newValue }
//    }
//    
//    open internal(set) var lastContentOffset: CGPoint?
//    
//    // MARK: - Methods
//    open func calculateRowsCountOrLess(at indexPath: IndexPath) -> Int {
//        self.sections
//            .prefix(indexPath.section + 1)
//            .enumerated()
//            .reduce(0, { sum, item in
//                let section = item.element
//                let sectionIndex = item.offset
//
//                let rowsPrefix = sectionIndex == indexPath.section ?
//                    indexPath.row + 1 :
//                    section.rows.count
//
//                return sum + section.rows.prefix(rowsPrefix).count
//            })
//    }
//    
//    open var indexPathOfFirstRow: IndexPath? {
//        guard !self.sections.isEmpty, self.sections.first?.rows.isEmpty == false else { return nil }
//
//        return .init(row: .zero, section: .zero)
//    }
//
//    open var indexPathOfLastRow: IndexPath? {
//        guard !self.sections.isEmpty, self.sections.first?.rows.isEmpty == false else { return nil }
//        let row = (self.sections.last?.rows.endIndex ?? 1) - 1
//        let section = self.sections.endIndex - 1
//
//        return .init(row: row, section: section)
//    }
//    
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
//        if offsetToBottom == 0, !self.sections.rowsIsEmpty {
//            tableView.dataOutput?.bottomAchived(tableView)
//        }
//    }
//    
//    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard
//            let tableView = self.tableView,
//            let cell = tableView.cellForRow(at: indexPath),
//            let model = self.sections.getRow(at: indexPath)
//        else { return }
//
//        tableView.dataOutput?.selectRow(tableView, indexPath: indexPath, cell: cell, row: model)
//    }
//    
//    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let model = self.sections.getRow(at: indexPath) else { return UITableView.automaticDimension }
//
//        return model.cellHeight
//    }
//    
//    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        guard let model = self.sections.getRow(at: indexPath) else { return UITableView.automaticDimension }
//
//        return model.cellEstimatedHeight
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
//    // MARK: - UITableViewDelegate + Header In Section
//    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard
//            let model = self.sections[section].header,
//            let viewIdentifier = model.viewIdentifier,
//            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier) as? DPTableViewHeaderFooterView
//        else {
//            return nil
//        }
//
//        view._model = model
//        return view
//    }
//
//    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        guard let model = self.sections[section].header else { return .zero }
//
//        return model.viewHeight
//    }
//
//    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        guard let model = self.sections[section].header else { return .zero }
//
//        return model.viewEstimatedHeight
//    }
//
//    // MARK: - UITableViewDelegate + Footer In Section
//    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard
//            let model = self.sections[section].footer,
//            let viewIdentifier = model.viewIdentifier,
//            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier) as? DPTableViewHeaderFooterView
//        else {
//            return nil
//        }
//
//        view._model = model
//        return view
//    }
//
//    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        guard let model = self.sections[section].footer else { return .zero }
//
//        return model.viewEstimatedHeight
//    }
//
//    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        guard let model = self.sections[section].footer else { return .zero }
//
//        return model.viewEstimatedHeight
//    }
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
