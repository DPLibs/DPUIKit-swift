//
//  DPTableAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

/// Component for managing a [UITableView](https://developer.apple.com/documentation/uikit/uitableview).
open class DPTableAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Init
    public init(
        rowAdapters: [DPTableRowAdapterType] = [],
        titleAdapters: [DPTableTitleAdapterType] = []
    ) {
        super.init()
        self.addRowAdapters(rowAdapters)
        self.addTitleAdapters(titleAdapters)
    }
    
    // MARK: - Types
    public typealias Closure = () -> Void
    public typealias RowContext = (cell: DPTableRowCellType, model: DPRepresentableModel, indexPath: IndexPath)
    public typealias RowContextClosure = (RowContext) -> Void
    public typealias RowContextToSwipeActionsConfiguration = (RowContext) -> UISwipeActionsConfiguration?
    public typealias RowContextToCGFloat = ((model: DPRepresentableModel, indexPath: IndexPath)) -> CGFloat?
    public typealias TitleContextToCGFloat = ((model: DPRepresentableModel, section: Int)) -> CGFloat?
    
    // MARK: - Props
    
    /// Weak reference to ``DPTableView``.
    ///
    /// When installed, this adapter is matched to the [UITableViewDelegate](https://developer.apple.com/documentation/uikit/uitableviewdelegate) and [UITableViewDataSource](https://developer.apple.com/documentation/uikit/uitableviewdatasource) of the ``DPTableView``.
    open weak var tableView: DPTableView? {
        didSet {
            self.tableView?.dataSource = self
            self.tableView?.delegate = self
        }
    }
    
    /// An array of sections.
    ///
    /// Used to display `cells` and other `subviews` of a ``tableView``.
    open var sections: [DPTableSectionType] = []
    
    open internal(set) var lastContentOffset: CGPoint?
    
    /// Cells adapters.
    open internal(set) var rowAdapters: [String: DPTableRowAdapterType] = [:]
    
    /// Titles views adapters.
    open internal(set) var titleAdapters: [String: DPTableTitleAdapterType] = [:]
    
    /// Registered cell IDs.
    open internal(set) var registeredСellIdentifiers: Set<String> = []
    
    /// Registered header/footer view identifiers.
    open internal(set) var registeredHeaderFooterViewsIdentifiers: Set<String> = []
    
    /// Called int the ``tableView(_:didSelectRowAt:)``.
    open var didSelectRow: RowContextClosure?
    
    /// Called int the ``tableView(_:didDeselectRowAt:)``.
    open var didDeselectRow: RowContextClosure?
    
    /// Called int the ``tableView(_:cellForRowAt:)``.
    open var onCellForRow: RowContextClosure?
    
    /// Called int the ``tableView(_:willDisplay:forRowAt:)``.
    open var willDisplayRow: RowContextClosure?
    
    /// Called int the ``tableView(_:heightForRowAt:)`` if ``DPTableRowAdapter/onCellHeight(model:indexPath:)`` return `nil`.
    open var onHeightForRow: RowContextToCGFloat?
    
    /// Called int the ``tableView(_:estimatedHeightForRowAt:)``  if ``DPTableRowAdapter/onCellEstimatedHeight(model:indexPath:)`` return `nil`.
    open var onEstimatedHeightForRow: RowContextToCGFloat?
    
    /// Called int the ``tableView(_:willDisplay:forRowAt:)`` when the first cell is displayed.
    open var onDisplayFirstRow: Closure?
    
    /// Called int the ``tableView(_:willDisplay:forRowAt:)`` when the last cell is displayed.
    open var onDisplayLastRow: Closure?
    
    /// Called int the ``tableView(_:willBeginEditingRowAt:)``.
    open var willBeginEditingRow: RowContextClosure?
    
    /// Called int the ``tableView(_:didEndEditingRowAt:)``.
    open var didEndEditingRow: RowContextClosure?
    
    /// Called int the ``tableView(_:leadingSwipeActionsConfigurationForRowAt:)``  if ``DPTableRowAdapter/onCellLeading(cell:model:indexPath:)`` return `nil`.
    open var onCellLeading: RowContextToSwipeActionsConfiguration?
    
    /// Called int the ``tableView(_:trailingSwipeActionsConfigurationForRowAt:)``  if ``DPTableRowAdapter/onCellTrailing(cell:model:indexPath:)`` return `nil`.
    open var onCellTrailing: RowContextToSwipeActionsConfiguration?
    
    /// Called int the ``tableView(_:heightForHeaderInSection:)``  if ``DPTableTitleAdapter/onViewHeight(model:section:)`` return `nil`.
    open var onHeightForHeaderInSection: TitleContextToCGFloat?
    
    /// Called int the ``tableView(_:estimatedHeightForHeaderInSection:)``  if ``DPTableTitleAdapter/onViewEstimatedHeight(model:section:)`` return `nil`.
    open var onEstimatedHeightForHeaderInSection: TitleContextToCGFloat?
    
    /// Called int the ``tableView(_:heightForFooterInSection:)`` if ``DPTableTitleAdapter/onViewHeight(model:section:)`` return `nil`.
    open var onHeightForFooterInSection: TitleContextToCGFloat?
    
    /// Called int the ``tableView(_:estimatedHeightForFooterInSection:)`` if ``DPTableTitleAdapter/onViewEstimatedHeight(model:section:)`` return `nil`.
    open var onEstimatedHeightForFooterInSection: TitleContextToCGFloat?
    
    /// Called int the ``scrollViewDidScroll(_:)``.
    open var didScroll: (((direction: UITableView.ScrollPosition, isDragging: Bool, isAchived: Bool)) -> Void)?
    
    // MARK: - Methods
    
    /// Add adapters for cells.
    open func addRowAdapters(_ rowAdapters: [DPTableRowAdapterType]) {
        for adapter in rowAdapters {
            self.rowAdapters[adapter.modelRepresentableIdentifier] = adapter
        }
    }
    
    /// Add adapters for titles views.
    open func addTitleAdapters(_ titleAdapters: [DPTableTitleAdapterType]) {
        for adapter in titleAdapters {
            self.titleAdapters[adapter.modelRepresentableIdentifier] = adapter
        }
    }
    
    /// Reload data with a new array of sections.
    ///
    /// Install new sections and call `tableView.reloadData()`.
    ///
    /// - Parameter sections: new array of sections. Will be installed in ``sections``.
    open func reloadData(_ sections: [DPTableSectionType]) {
        self.sections = sections
        self.tableView?.reloadData()
    }
    
    /// Update data using an updates array.
    ///
    /// Call `tableView.performBatchUpdates()` with updates array.
    ///
    /// - Parameter updates: array of ``DPTableUpdate``.
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
        
        if let cell = cell as? DPTableRowCellType {
            cell._model = model
            
            self.onCellForRow?((cell, model, indexPath))
            adapter.onCell(cell: cell, model: model, indexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? DPTableRowCellType, let model = self.sections.row(at: indexPath) {
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
        
        return
            adapter?.onCellHeight(model: model, indexPath: indexPath) ??
            self.onHeightForRow?((model, indexPath)) ??
            tableView.rowHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let model = self.sections.row(at: indexPath) else { return tableView.estimatedRowHeight }
        let adapter = self.rowAdapters[model._representableIdentifier]
        
        return
            adapter?.onCellEstimatedHeight(model: model, indexPath: indexPath) ??
            self.onEstimatedHeightForRow?((model, indexPath)) ??
            tableView.estimatedRowHeight
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

        if let view = view as? DPTableTitleViewType {
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
        
        if let view = view as? DPTableTitleViewType {
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
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellType,
            let model = self.sections.row(at: indexPath),
            let adapter = self.rowAdapters[model._representableIdentifier]
        else { return nil }

        return adapter.onCellLeading(cell: cell, model: model, indexPath: indexPath) ?? self.onCellLeading?((cell, model, indexPath)) ?? nil
    }

    open func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellType,
            let model = self.sections.row(at: indexPath),
            let adapter = self.rowAdapters[model._representableIdentifier]
        else { return nil }

        return adapter.onCellTrailing(cell: cell, model: model, indexPath: indexPath) ?? self.onCellTrailing?((cell, model, indexPath)) ?? nil
    }
    
    // MARK: - UITableViewDelegate + Select
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellType,
            let model = self.sections.row(at: indexPath)
        else { return }

        self.didSelectRow?((cell, model, indexPath))
        self.rowAdapters[model._representableIdentifier]?.didSelect(cell: cell, model: model, indexPath: indexPath)
    }

    open func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellType,
            let model = self.sections.row(at: indexPath)
        else { return }

        self.didDeselectRow?((cell, model, indexPath))
        self.rowAdapters[model._representableIdentifier]?.didDeselect(cell: cell, model: model, indexPath: indexPath)
    }

    // MARK: - UITableViewDelegate + Edit
    open func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellType,
            let model = self.sections.row(at: indexPath)
        else { return }

        self.willBeginEditingRow?((cell, model, indexPath))
        self.rowAdapters[model._representableIdentifier]?.willBeginEditing(cell: cell, model: model, indexPath: indexPath)
    }

    open func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard
            let indexPath = indexPath,
            let cell = tableView.cellForRow(at: indexPath) as? DPTableRowCellType,
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
