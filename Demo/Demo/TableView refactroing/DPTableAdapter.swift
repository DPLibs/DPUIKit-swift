//
//  DPTableAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

protocol DPTableAdapterOutput {
//    func tableAdapterDidSelectRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
//    func tableAdapterDidDeselectRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
//    func tableAdapterOnCellForRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
//    func tableAdapterWillDisplayRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
//    func tableAdapterOnDisplayFirstRow()
//    func tableAdapterOnDisplayLastRow()
//    func tableAdapterWillBeginEditingRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
//    func tableAdapterDidEndEditingRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath)
//    func tableAdapterOnCellLeading(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    func tableAdapterOnCellTrailing(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) -> UISwipeActionsConfiguration?
//    func tableAdapterDidScroll(position: UITableView.ScrollPosition, isDragging: Bool, positionAchived: Bool)
//}
//
//extension DPTableAdapterOutput {
//    func tableAdapterDidSelectRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) {}
//    func tableAdapterDidDeselectRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) {}
//    func tableAdapterOnCellForRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) {}
//    func tableAdapterWillDisplayRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) {}
//    func tableAdapterOnDisplayFirstRow() {}
//    func tableAdapterOnDisplayLastRow() {}
//    func tableAdapterWillBeginEditingRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) {}
//    func tableAdapterDidEndEditingRow(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) {}
//    func tableAdapterOnCellLeading(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) -> UISwipeActionsConfiguration? { nil }
//    func tableAdapterOnCellTrailing(cell: DPTableRowCellProtocol, model: DPTableRowModelProtocol, indexPath: IndexPath) -> UISwipeActionsConfiguration? { nil }
//    func tableAdapterDidScroll(position: UITableView.ScrollPosition, isDragging: Bool, positionAchived: Bool) {}
//    
//}

open class DPTableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Init
    public override init() {}
    
    // MARK: - Props
    open weak var tableView: DPTableView? {
        didSet {
            self.tableView?.dataSource = self
            self.tableView?.delegate = self
        }
    }
    
    open var sections: [DPTableSectionProtocol] {
        get { self.tableView?.sections ?? [] }
        set { self.tableView?.sections = newValue }
    }
    
    open internal(set) var lastContentOffset: CGPoint?
    open internal(set) var registeredСellIdentifiers: Set<String> = []
    open internal(set) var registeredHeaderFooterViewsIdentifiers: Set<String> = []
    
    open var didSelectRow: DPTableCellContextClosure?
    open var didDeselectRow: DPTableCellContextClosure?
    
    open var onCellForRow: DPTableCellContextClosure?
    open var willDisplayRow: DPTableCellContextClosure?
    
    open var onDisplayFirstRow: (() -> Void)?
    open var onDisplayLastRow: (() -> Void)?
    
    open var willBeginEditingRow: DPTableCellContextClosure?
    open var didEndEditingRow: DPTableCellContextClosure?
    
    open var onCellLeading: ((DPTableCellContext) -> UISwipeActionsConfiguration?)?
    open var onCellTrailing: ((DPTableCellContext) -> UISwipeActionsConfiguration?)?
    
    open var didScroll: (((position: UITableView.ScrollPosition, isDragging: Bool, positionAchived: Bool)) -> Void)?
    
//    // MARK: - Methods
//    open func calculateRowsCountOrLess(at indexPath: IndexPath) -> Int {
//        return self.sections
//            .prefix(indexPath.section + 1)
//            .enumerated()
//            .reduce(0, { sum, item in
//                let rowsPrefix = item.offset == indexPath.section ? indexPath.row : item.element.rows.count
//                return sum + item.element.rows.prefix(rowsPrefix).count
//            })
//    }
    
    // MARK: - UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return .zero }
        return self.sections[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = self.sections.row(at: indexPath) else { return UITableViewCell() }
        let cellIdentifier = String(describing: row.cellClass)
        
        if !self.registeredСellIdentifiers.contains(cellIdentifier) {
            tableView.register(row.cellClass, forCellReuseIdentifier: cellIdentifier)
            self.registeredСellIdentifiers.insert(cellIdentifier)
        }
         
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? DPTableRowCellProtocol {
            cell._model = row
            
            let context: DPTableCellContext = (cell, row, indexPath)
            self.onCellForRow?(context)
            row.onCell?(context)
        }

        return cell
    }
    
    // MARK: - UITableViewDelegate
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DPTableRowCellProtocol, let model = self.sections.row(at: indexPath) {
            let context: DPTableCellContext = (cell, model, indexPath)
            self.willDisplayRow?(context)
            model.willDisplay?(context)
        }
        
        if indexPath == IndexPath(row: 0, section: 0) {
            self.onDisplayFirstRow?()
        }
        
        if !self.sections.isEmpty, indexPath == IndexPath(row: (self.sections.last?.rows.count ?? 0) - 1, section: self.sections.count - 1) {
            self.onDisplayLastRow?()
        }
        
//        let offsetToTop = self.calculateRowsCountOrLess(at: indexPath)
//        let offsetToBottom = self.sections.reduce(0, { $0 + $1.rows.count }) - offsetToTop - 1
//
//        if offsetToTop == 0 {
//            self.onDisplayFirstRow?()
//        }
//
//        if offsetToBottom == 0, !self.sections.isEmpty {
//            self.onDisplayLastRow?()
//        }
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.sections.row(at: indexPath)?.cellHeight ?? tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        self.sections.row(at: indexPath)?.cellEstimatedHeight ?? tableView.estimatedRowHeight
    }
    
    // MARK: - UITableViewDelegate + Header In Section
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.sections.header(at: section) else { return UIView() }
        let viewIdentifier = String(describing: header.viewClass)
        
        if !self.registeredHeaderFooterViewsIdentifiers.contains(viewIdentifier) {
            tableView.register(header.viewClass, forHeaderFooterViewReuseIdentifier: viewIdentifier)
            self.registeredHeaderFooterViewsIdentifiers.insert(viewIdentifier)
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier)
        
        if let view = view as? DPTableViewHeaderFooterViewProtocol {
            view._model = header
        }
        
        return view
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.sections.header(at: section)?.viewHeight ?? tableView.sectionHeaderHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        self.sections.header(at: section)?.viewEstimatedHeight ?? tableView.estimatedSectionHeaderHeight
    }

    // MARK: - UITableViewDelegate + Footer In Section
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = self.sections.footer(at: section) else { return nil }
        let viewIdentifier = String(describing: footer.viewClass)
        
        if !self.registeredHeaderFooterViewsIdentifiers.contains(viewIdentifier) {
            tableView.register(footer.viewClass, forHeaderFooterViewReuseIdentifier: viewIdentifier)
            self.registeredHeaderFooterViewsIdentifiers.insert(viewIdentifier)
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: footer.viewClass))
        
        if let view = view as? DPTableViewHeaderFooterViewProtocol {
            view._model = footer
        }
        
        return view
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.sections.footer(at: section)?.viewHeight ?? tableView.sectionFooterHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        self.sections.footer(at: section)?.viewEstimatedHeight ?? tableView.estimatedSectionFooterHeight
    }

    // MARK: - UITableViewDelegate + Swipe
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return .empty }

        let context: DPTableCellContext = (cell, model, indexPath)
        return model.onCellLeading?(context) ?? self.onCellLeading?(context) ?? .empty
    }

    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return .empty }

        let context: DPTableCellContext = (cell, model, indexPath)
        return model.onCellTrailing?(context) ?? self.onCellTrailing?(context) ?? .empty
    }
    
    // MARK: - UITableViewDelegate + Select
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = self.tableView?.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }
        
        let context: DPTableCellContext = (cell, model, indexPath)
        self.didSelectRow?(context)
        model.didSelect?(context)
    }
    
    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard
            let cell = self.tableView?.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }
        
        let context: DPTableCellContext = (cell, model, indexPath)
        self.didDeselectRow?(context)
        model.didDeselect?(context)
    }

    // MARK: - UITableViewDelegate + Edit
    open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }

        let context: DPTableCellContext = (cell, model, indexPath)
        self.willBeginEditingRow?(context)
        model.willBeginEditing?(context)
    }

    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard
            let indexPath = indexPath,
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }
        
        let context: DPTableCellContext = (cell, model, indexPath)
        self.didEndEditingRow?(context)
        model.didEndEditing?(context)
    }
    
    // MARK: - UITableViewDelegate + Scroll
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset
        let isDragging = scrollView.isDragging

        if self.lastContentOffset == nil {
            self.lastContentOffset = contentOffset
        }

        guard let lastContentOffset = self.lastContentOffset else { return }

        let scrollToPosition: UITableView.ScrollPosition = lastContentOffset.y > contentOffset.y ? .top : .bottom
        
        let bottomOffset = CGPoint(
            x: 0,
            y: scrollView.contentSize.height - scrollView.frame.size.height + scrollView.contentInset.top + scrollView.contentInset.bottom
        )
        
        let topAchived = contentOffset.y <= -scrollView.contentInset.top
        let bottomAchived = contentOffset.y >= (bottomOffset.y < 0 ? 0 : bottomOffset.y)
        let isAchived = scrollToPosition == .top ? topAchived : bottomAchived

        self.didScroll?((scrollToPosition, isDragging, isAchived))
        
        if isDragging {
            self.lastContentOffset = contentOffset
        }

//        guard isDragging else { return }
//
//        switch scrollToPosition {
//        case .top:
//            let pointForCell = CGPoint(x: offset.x, y: offset.y < 0 ? 0 : offset.y)
//
//            if let indexPathForCell = tableView.indexPathForRow(at: pointForCell) {
//                let offsetToTop = self.calculateRowsCountOrLess(at: indexPathForCell)
////                self.onScrolling?((.top, offsetToTop))
//            }
//        case .bottom:
//            let pointForCell = CGPoint(x: offset.x, y: offset.y + tableView.frame.height)
//
//            if let indexPathForCell = tableView.indexPathForRow(at: pointForCell) {
//                let offsetToBottom = self.sections.reduce(0, { $0 + $1.rows.count }) - self.calculateRowsCountOrLess(at: indexPathForCell)
////                self.onScrolling?((.bottom, offsetToBottom))
//            }
//        default:
//            break
//        }
//
//        let topAchived = offset.y <= -scrollView.contentInset.top
//        let bottomAchived = offset.y >= (bottomOffset.y < 0 ? 0 : bottomOffset.y)
//
//        self.onScrolled?((.top, topAchived))
//        self.onScrolled?((.bottom, bottomAchived))


    }
    
}
