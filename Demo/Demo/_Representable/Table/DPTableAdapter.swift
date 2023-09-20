//
//  DPTableAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

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
    
    open var onCellLeading: DPTableCellContextToSwipeActionsConfiguration?
    open var onCellTrailing: DPTableCellContextToSwipeActionsConfiguration?
    
    open var didScroll: (((direction: UITableView.ScrollPosition, isDragging: Bool, isAchived: Bool)) -> Void)?
    
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
        let direction: UITableView.ScrollPosition = lastContentOffset.y > contentOffset.y ? .top : .bottom
        
        let bottomOffset = CGPoint(
            x: 0,
            y: scrollView.contentSize.height - scrollView.frame.size.height + scrollView.contentInset.top + scrollView.contentInset.bottom
        )
        
        let topAchived = contentOffset.y <= -scrollView.contentInset.top
        let bottomAchived = contentOffset.y >= (bottomOffset.y < 0 ? 0 : bottomOffset.y)
        let isAchived = direction == .top ? topAchived : bottomAchived

        self.didScroll?((direction, isDragging, isAchived))
        
        if isDragging {
            self.lastContentOffset = contentOffset
        }
    }
    
}
