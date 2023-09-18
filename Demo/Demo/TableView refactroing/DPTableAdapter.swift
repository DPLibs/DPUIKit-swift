//
//  DPTableAdapterProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

open class DPTableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
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
    
    open var didSelectRow: DPTableCellContextClosure?
    open var didDeselectRow: DPTableCellContextClosure?
    
    open var onCellForRow: DPTableCellContextClosure?
    open var willDisplayRow: DPTableCellContextClosure?
    
    open var willBeginEditingRow: DPTableCellContextClosure?
    open var didEndEditingRow: DPTableCellContextClosure?
    
    open var onCellLeading: ((DPTableCellContext) -> UISwipeActionsConfiguration?)?
    open var onCellTrailing: ((DPTableCellContext) -> UISwipeActionsConfiguration?)?
    
    open var onScrolling: (((position: UITableView.ScrollPosition, rowsOffset: Int)) -> Void)?
    open var didScroll: (((position: UITableView.ScrollPosition, isDragging: Bool)) -> Void)?
    open var onScrolled: (((position: UITableView.ScrollPosition, isAchived: Bool)) -> Void)?
    
    open var onTopAchived: (() -> Void)?
    open var onBottomAchived: (() -> Void)?
    
    // MARK: - Methods
    open func calculateRowsCountOrLess(at indexPath: IndexPath) -> Int {
        self.sections
            .prefix(indexPath.section + 1)
            .enumerated()
            .reduce(0, { sum, item in
                let section = item.element
                let sectionIndex = item.offset

                let rowsPrefix = sectionIndex == indexPath.section ?
                    indexPath.row + 1 :
                    section.rows.count

                return sum + section.rows.prefix(rowsPrefix).count
            })
    }
    
    open var indexPathOfFirstRow: IndexPath? {
        guard !self.sections.isEmpty, self.sections.first?.rows.isEmpty == false else { return nil }

        return .init(row: .zero, section: .zero)
    }

    open var indexPathOfLastRow: IndexPath? {
        guard !self.sections.isEmpty, self.sections.first?.rows.isEmpty == false else { return nil }
        let row = (self.sections.last?.rows.endIndex ?? 1) - 1
        let section = self.sections.endIndex - 1

        return .init(row: row, section: section)
    }
    
    // MARK: - UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return .zero }
        return self.sections[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = self.sections.row(at: indexPath) else { return .init() }
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: row.cellClass), for: indexPath)
        
        if let cell = cell as? DPTableRowCellProtocol {
            cell._model = row
            
            let context: DPTableCellContext = (cell, row, indexPath)
            self.onCellForRow?(context)
            row.onCell?(context)
        }

        return cell
    }
    
    // MARK: - UITableViewDelegate + Row
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol, let model = self.sections.row(at: indexPath) {
            let context: DPTableCellContext = (cell, model, indexPath)
            self.willDisplayRow?(context)
            model.willDisplay?(context)
        }

        let offsetToTop = self.calculateRowsCountOrLess(at: indexPath)
        self.onScrolling?((.top, offsetToTop))
        
        if offsetToTop == 0 {
            self.onTopAchived?()
        }
        
        let offsetToBottom = self.sections.reduce(0, { $0 + $1.rows.count }) - offsetToTop
        self.onScrolling?((.bottom, offsetToBottom))
        
        if offsetToBottom == 0, !self.sections.isEmpty {
            self.onBottomAchived?()
        }
    }
    
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
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.sections.row(at: indexPath)?.cellHeight ?? DPTableConstants.Cell.heihgt
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        self.sections.row(at: indexPath)?.cellEstimatedHeight ?? DPTableConstants.Cell.estimatedHeight
    }
    
    // MARK: - UITableViewDelegate + Scroll
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset

        if self.lastContentOffset == nil {
            self.lastContentOffset = offset
        }

        guard
            let lastOffset = self.lastContentOffset,
            let tableView = self.tableView
        else { return }

        let scrollToPosition: UITableView.ScrollPosition = lastOffset.y > offset.y ? .top : .bottom
        let bottomOffset = tableView.calculateBottomOffset()
        let isDragging = scrollView.isDragging

        self.didScroll?((scrollToPosition, isDragging))

        guard isDragging else { return }

        switch scrollToPosition {
        case .top:
            let pointForCell = CGPoint(x: offset.x, y: offset.y < 0 ? 0 : offset.y)

            if let indexPathForCell = tableView.indexPathForRow(at: pointForCell) {
                let offsetToTop = self.calculateRowsCountOrLess(at: indexPathForCell)
                self.onScrolling?((.top, offsetToTop))
            }
        case .bottom:
            let pointForCell = CGPoint(x: offset.x, y: offset.y + tableView.frame.height)

            if let indexPathForCell = tableView.indexPathForRow(at: pointForCell) {
                let offsetToBottom = self.sections.reduce(0, { $0 + $1.rows.count }) - self.calculateRowsCountOrLess(at: indexPathForCell)
                self.onScrolling?((.bottom, offsetToBottom))
            }
        default:
            break
        }

        let topAchived = offset.y <= -scrollView.contentInset.top
        let bottomAchived = offset.y >= (bottomOffset.y < 0 ? 0 : bottomOffset.y)

        self.onScrolled?((.top, topAchived))
        self.onScrolled?((.bottom, bottomAchived))

        self.lastContentOffset = offset
    }
    
    // MARK: - UITableViewDelegate + Header In Section
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = self.sections[section].header else { return UIView() }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: header.viewClass))
        (view as? DPTableViewHeaderFooterViewProtocol)?._model = header
        return view
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let model = self.sections[section].header else { return .zero }

        return model.viewHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard let model = self.sections[section].header else { return .zero }

        return model.viewEstimatedHeight
    }

    // MARK: - UITableViewDelegate + Footer In Section
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = self.sections[section].footer else { return nil }
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: footer.viewClass))
        (view as? DPTableViewHeaderFooterViewProtocol)?._model = footer
        return view
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.sections[section].footer?.viewHeight ?? .zero
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        self.sections[section].footer?.viewEstimatedHeight ?? .zero
    }

    // MARK: - UITableViewDelegate + Swipe
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return .empty }

        let context: DPTableCellContext = (cell, model, indexPath)
        return self.onCellLeading?(context) ?? model.onCellLeading?(context) ?? .empty
    }

    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return .empty }

        let context: DPTableCellContext = (cell, model, indexPath)
        return self.onCellTrailing?(context) ?? model.onCellTrailing?(context) ?? .empty
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
    
}
