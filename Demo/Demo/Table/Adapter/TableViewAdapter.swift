//
//  TableViewAdapter.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

open class TableViewAdapter: NSObject, TableViewAdapterProtocol {
    
    // MARK: - Props
    public typealias CellContext = (cell: UITableViewCell, model: TableViewCellModelProtocol, indexPath: IndexPath)
    public typealias CellContextClosure = (CellContext) -> Void
    
    public typealias HeaderFotterContext = (view: UITableViewHeaderFooterView, model: TableViewHeaderFooterModelProtocol, section: Int)
    public typealias HeaderFotterContextClosure = (HeaderFotterContext) -> Void
    
    open var sections: [TableViewSectionProtocol] = []
    public private(set) var identifiers: Set<String> = []
    
    open var onCellForRow: CellContextClosure?
    open var onWillDisplayRow: CellContextClosure?
    
    open var didSelectRow: CellContextClosure?
    open var didDeselectRow: CellContextClosure?
    
    open var onViewForHeader: HeaderFotterContextClosure?
    open var onViewForFooter: HeaderFotterContextClosure?
    
    // MARK: - Methods
    open func section(at index: Int) -> TableViewSectionProtocol? {
        guard self.sections.indices.contains(index) else { return nil }
        return self.sections[index]
    }
    
    open func model(at indexPath: IndexPath) -> TableViewCellModelProtocol? {
        guard
            let section = self.section(at: indexPath.section),
            section.models.indices.contains(indexPath.row)
        else { return nil }
        
        return section.models[indexPath.row]
    }
    
    open func identifier(for `class`: AnyClass) -> String {
        String(describing: `class`)
    }
    
    // MARK: - UITableViewDataSource - Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return 0 }
        return self.sections[section].models.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = self.model(at: indexPath) else { return .init() }
        
        let cellIdentifier = self.identifier(for: model.cellClass)
        
        if !self.identifiers.contains(cellIdentifier) {
            tableView.register(model.cellClass, forCellReuseIdentifier: cellIdentifier)
            self.identifiers.insert(cellIdentifier)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let cell = cell as? TableViewCellProtocol {
            cell._model = model
        }
        
        self.onCellForRow?((cell, model, indexPath))
        
        return cell
    }
    
    // MARK: - UITableViewDelegate - Methods
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let model = self.model(at: indexPath) else { return }
        self.onWillDisplayRow?((cell, model, indexPath))
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.model(at: indexPath)?.cellHeight ?? TableConstants.cellHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        self.model(at: indexPath)?.cellEstimatedHeight ?? TableConstants.cellEstimatedHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath),
            let model = self.model(at: indexPath)
        else { return }
        
        self.didSelectRow?((cell, model, indexPath))
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard
            let cell = tableView.cellForRow(at: indexPath),
            let model = self.model(at: indexPath)
        else { return }
        
        self.didDeselectRow?((cell, model, indexPath))
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let model = self.section(at: section)?.header else { return UIView() }
        
        let viewIdentifier = self.identifier(for: model.viewClass)
        
        if !self.identifiers.contains(viewIdentifier) {
            tableView.register(model.viewClass, forHeaderFooterViewReuseIdentifier: viewIdentifier)
            self.identifiers.insert(viewIdentifier)
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier)
        
        if let view = view as? TableViewHeaderFooterViewProtocol {
            view._model = model
        }
        
        if let view {
            self.onViewForHeader?((view, model, section))
        }
        
        return view
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let model = self.section(at: section)?.fotter else { return UIView() }
        
        let viewIdentifier = self.identifier(for: model.viewClass)
        
        if !self.identifiers.contains(viewIdentifier) {
            tableView.register(model.viewClass, forHeaderFooterViewReuseIdentifier: viewIdentifier)
            self.identifiers.insert(viewIdentifier)
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: viewIdentifier)
        
        if let view = view as? TableViewHeaderFooterViewProtocol {
            view._model = model
        }
        
        if let view {
            self.onViewForFooter?((view, model, section))
        }
        
        return view
    }
    
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let model = self.section(at: section)?.header else { return TableConstants.headerFooterHeight }
        return model.viewHeight
    }
    
    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let model = self.section(at: section)?.fotter else { return TableConstants.headerFooterHeight }
        return model.viewHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        guard let model = self.section(at: section)?.header else { return TableConstants.headerFooterEstimatedHeight }
        return model.viewEstimatedHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        guard let model = self.section(at: section)?.fotter else { return TableConstants.headerFooterEstimatedHeight }
        return model.viewEstimatedHeight
    }
    
}
