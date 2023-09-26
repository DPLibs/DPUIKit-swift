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
    public init(
        rowAdapters: [DPTableRowAdapterProtocol] = [],
        titleAdapters: [DPTableTitleAdapterProtocol] = []
    ) {
        super.init()
        self.addRowAdapters(rowAdapters)
        self.addTitleAdapters(titleAdapters)
    }
    
    // MARK: - Types
    public typealias Closure = () -> Void
    public typealias RowContext = (cell: DPTableRowCellProtocol, model: DPRepresentableModel, indexPath: IndexPath)
    public typealias RowContextClosure = (RowContext) -> Void
    public typealias RowContextToSwipeActionsConfiguration = (RowContext) -> UISwipeActionsConfiguration?
    public typealias RowContextToCGFloat = (RowContext) -> CGFloat?
    public typealias TitleContextToCGFloat = ((model: DPRepresentableModel, section: Int)) -> CGFloat?
    
    // MARK: - Props
    open weak var tableView: DPTableView? {
        didSet {
            self.tableView?.dataSource = self
            self.tableView?.delegate = self
        }
    }
    
    open var sections: [DPTableSectionProtocol] = []
    
    open internal(set) var lastContentOffset: CGPoint?
    open internal(set) var rowAdapters: [String: DPTableRowAdapterProtocol] = [:]
    open internal(set) var titleAdapters: [String: DPTableTitleAdapterProtocol] = [:]
    open internal(set) var registeredСellIdentifiers: Set<String> = []
    open internal(set) var registeredHeaderFooterViewsIdentifiers: Set<String> = []
    
    open var didSelectRow: RowContextClosure?
    open var didDeselectRow: RowContextClosure?
    
    open var onCellForRow: RowContextClosure?
    open var willDisplayRow: RowContextClosure?
    
    open var onHeightForRow: RowContextToCGFloat?
    open var onEstimatedHeightForRow: RowContextToCGFloat?
    
    open var onDisplayFirstRow: Closure?
    open var onDisplayLastRow: Closure?
    
    open var willBeginEditingRow: RowContextClosure?
    open var didEndEditingRow:RowContextClosure?
    
    open var onCellLeading: RowContextToSwipeActionsConfiguration?
    open var onCellTrailing: RowContextToSwipeActionsConfiguration?
    
    open var onHeightForHeaderInSection: TitleContextToCGFloat?
    open var onEstimatedHeightForHeaderInSection: TitleContextToCGFloat?
    
    open var onHeightForFooterInSection: TitleContextToCGFloat?
    open var onEstimatedHeightForFooterInSection: TitleContextToCGFloat?
    
    open var didScroll: (((direction: UITableView.ScrollPosition, isDragging: Bool, isAchived: Bool)) -> Void)?
    
    // MARK: - Methods
    open func addRowAdapters(_ rowAdapters: [DPTableRowAdapterProtocol]) {
        for adapter in rowAdapters {
            self.rowAdapters[adapter.modelRepresentableIdentifier] = adapter
        }
    }
    
    open func addTitleAdapters(_ titleAdapters: [DPTableTitleAdapterProtocol]) {
        for adapter in titleAdapters {
            self.titleAdapters[adapter.modelRepresentableIdentifier] = adapter
        }
    }
    
    open func reloadData(_ sections: [DPTableSectionProtocol]) {
        self.sections = sections
        self.tableView?.reloadData()
    }
    
    open func performBatchUpdates(_ updates: [DPTableUpdate], completion: ((Bool) -> Void)? = nil) {
        self.tableView?.performBatchUpdates(
            { [weak self] in
                guard let self = self else { return }
                updates.forEach({ $0.perform(self) })
            },
            completion: completion
        )
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
        guard
            let model = self.sections.row(at: indexPath),
            let adapter = self.rowAdapters[model._representableIdentifier]
        else { return UITableViewCell() }
        
        let cellClass = adapter.cellClass
        let cellIdentifier = String(describing: cellClass)
        
        if !self.registeredСellIdentifiers.contains(cellIdentifier) {
            tableView.register(cellClass, forCellReuseIdentifier: cellIdentifier)
            self.registeredСellIdentifiers.insert(cellIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? DPTableRowCellProtocol {
            cell._model = model
            
            self.onCellForRow?((cell, model, indexPath))
            adapter.onCell(cell: cell, model: model, indexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DPTableRowCellProtocol, let model = self.sections.row(at: indexPath) {
            self.willDisplayRow?((cell, model, indexPath))
            self.rowAdapters[model._representableIdentifier]?.willDisplay(cell: cell, model: model, indexPath: indexPath)
        }

        if indexPath == IndexPath(row: 0, section: 0) {
            self.onDisplayFirstRow?()
        }

        if !self.sections.isEmpty, indexPath == IndexPath(row: (self.sections.last?.rows.count ?? 0) - 1, section: self.sections.count - 1) {
            self.onDisplayLastRow?()
        }
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let model = self.sections.row(at: indexPath) else { return tableView.rowHeight }
        let adapter = self.rowAdapters[model._representableIdentifier]
        return adapter?.onCellHeight(model: model, indexPath: indexPath) ?? tableView.rowHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let model = self.sections.row(at: indexPath) else { return tableView.estimatedRowHeight }
        let adapter = self.rowAdapters[model._representableIdentifier]
        return adapter?.onCellEstimatedHeight(model: model, indexPath: indexPath) ?? tableView.estimatedRowHeight
    }
    
    // MARK: - UITableViewDelegate + Header In Section
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let header = self.sections.header(at: section),
            let adapter = self.titleAdapters[header._representableIdentifier]
        else { return nil }

        let viewClass = adapter.viewClass
        let viewIdentifier = String(describing: viewClass)

        if !self.registeredHeaderFooterViewsIdentifiers.contains(viewIdentifier) {
            tableView.register(viewClass, forHeaderFooterViewReuseIdentifier: viewIdentifier)
            self.registeredHeaderFooterViewsIdentifiers.insert(viewIdentifier)
        }

        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier)

        if let view = view as? DPTableTitleViewProtocol {
            view._model = header
        }

        return view
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard
            let model = self.sections.header(at: section),
            let adapter = self.titleAdapters[model._representableIdentifier]
        else { return 0 }
        
        return
            adapter.onViewHeight(model: model, section: section) ??
            self.onHeightForHeaderInSection?((model, section)) ??
            tableView.sectionHeaderHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard
            let model = self.sections.header(at: section),
            let adapter = self.titleAdapters[model._representableIdentifier]
        else { return 0 }
        
        return
            adapter.onViewEstimatedHeight(model: model, section: section) ??
            self.onEstimatedHeightForHeaderInSection?((model, section)) ??
            tableView.estimatedSectionHeaderHeight
    }

    // MARK: - UITableViewDelegate + Footer In Section
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard
            let footer = self.sections.footer(at: section),
            let adapter = self.titleAdapters[footer._representableIdentifier]
        else { return nil }
        
        let viewClass = adapter.viewClass
        let viewIdentifier = String(describing: viewClass)
        
        if !self.registeredHeaderFooterViewsIdentifiers.contains(viewIdentifier) {
            tableView.register(viewClass, forHeaderFooterViewReuseIdentifier: viewIdentifier)
            self.registeredHeaderFooterViewsIdentifiers.insert(viewIdentifier)
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier)
        
        if let view = view as? DPTableTitleViewProtocol {
            view._model = footer
        }
        
        return view
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard
            let model = self.sections.footer(at: section),
            let adapter = self.titleAdapters[model._representableIdentifier]
        else { return 0 }
        
        return
            adapter.onViewHeight(model: model, section: section) ??
            self.onHeightForFooterInSection?((model, section)) ??
            tableView.sectionFooterHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        guard
            let model = self.sections.footer(at: section),
            let adapter = self.titleAdapters[model._representableIdentifier]
        else { return 0 }
        
        return
            adapter.onViewEstimatedHeight(model: model, section: section) ??
            self.onEstimatedHeightForFooterInSection?((model, section)) ??
            tableView.estimatedSectionFooterHeight
    }

    // MARK: - UITableViewDelegate + Swipe
    open func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath),
            let adapter = self.rowAdapters[model._representableIdentifier]
        else { return nil }

        return adapter.onCellLeading(cell: cell, model: model, indexPath: indexPath) ?? self.onCellLeading?((cell, model, indexPath)) ?? nil
    }

    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath),
            let adapter = self.rowAdapters[model._representableIdentifier]
        else { return nil }

        return adapter.onCellTrailing(cell: cell, model: model, indexPath: indexPath) ?? self.onCellTrailing?((cell, model, indexPath)) ?? nil
    }
    
    // MARK: - UITableViewDelegate + Select
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = self.tableView?.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }

        self.didSelectRow?((cell, model, indexPath))
        self.rowAdapters[model._representableIdentifier]?.didSelect(cell: cell, model: model, indexPath: indexPath)
    }

    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard
            let cell = self.tableView?.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }

        self.didDeselectRow?((cell, model, indexPath))
        self.rowAdapters[model._representableIdentifier]?.didDeselect(cell: cell, model: model, indexPath: indexPath)
    }

    // MARK: - UITableViewDelegate + Edit
    open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }

        self.willBeginEditingRow?((cell, model, indexPath))
        self.rowAdapters[model._representableIdentifier]?.willBeginEditing(cell: cell, model: model, indexPath: indexPath)
    }

    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard
            let indexPath = indexPath,
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellProtocol,
            let model = self.sections.row(at: indexPath)
        else { return }
        
        self.didEndEditingRow?((cell, model, indexPath))
        self.rowAdapters[model._representableIdentifier]?.didEndEditing(cell: cell, model: model, indexPath: indexPath)
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
