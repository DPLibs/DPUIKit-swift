//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 24.01.2022.
//

import Foundation
import UIKit

public protocol DPTableAdapterOutput: AnyObject {
    func didSelectRow(_ adapter: DPTableAdapter, section: DPTableSectionAdapter, at indexPath: IndexPath, model: DPTableRowModel, cell: UITableViewCell)
}

open class DPTableAdapter: NSObject, DPTableAdapterProtocol {
    
    // MARK: - Init
    public init(sections: [DPTableSectionAdapter] = []) {
        self.sections = sections
    }
    
    // MARK: - Props
    open weak var output: DPTableAdapterOutput?
    open var sections: [DPTableSectionAdapter]
    
    // MARK: - Methods
    func getSection(atIndex index: Int) -> DPTableSectionAdapter? {
        self.sections.getSection(atIndex: index)
    }
    
    open func getSection(atIndexPath indexPath: IndexPath) -> DPTableSectionAdapter? {
        self.sections.getSection(atIndexPath: indexPath)
    }
    
}

// MARK: - UITableViewDataSource
extension DPTableAdapter: UITableViewDataSource {
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.sections.getSection(atIndex: section)?.tableView(tableView, numberOfRowsInSection: section) ?? .zero
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.sections.getSection(atIndexPath: indexPath)?.tableView(tableView, cellForRowAt: indexPath) ?? .init()
    }
    
}

// MARK: - UITableViewDelegate
extension DPTableAdapter: UITableViewDelegate {
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        #warning("Dev.WillDisplay")
    }
    
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.getSection(atIndexPath: indexPath)?.tableView(tableView, heightForRowAt: indexPath) ?? tableView.rowHeight
    }
    
    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        self.getSection(atIndexPath: indexPath)?.tableView(tableView, estimatedHeightForRowAt: indexPath) ?? tableView.estimatedRowHeight
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let section = self.getSection(atIndexPath: indexPath),
            let model = section.getRow(atIndexPath: indexPath),
            let cell = tableView.cellForRow(at: indexPath)
        else { return }
        
        section.tableView(tableView, didSelectRowAt: indexPath)
        self.output?.didSelectRow(self, section: section, at: indexPath, model: model, cell: cell)
    }
    
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        self.getSection(atIndex: section)?.tableView(tableView, viewForHeaderInSection: section)
    }

    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.getSection(atIndex: section)?.tableView(tableView, heightForHeaderInSection: section) ?? tableView.sectionHeaderHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        self.getSection(atIndex: section)?.tableView(tableView, estimatedHeightForHeaderInSection: section) ?? tableView.estimatedSectionHeaderHeight
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        self.getSection(atIndex: section)?.tableView(tableView, viewForFooterInSection: section)
    }

    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.getSection(atIndex: section)?.tableView(tableView, heightForFooterInSection: section) ?? tableView.sectionFooterHeight
    }

    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        self.getSection(atIndex: section)?.tableView(tableView, estimatedHeightForFooterInSection: section) ?? tableView.estimatedSectionHeaderHeight
    }
    
}
