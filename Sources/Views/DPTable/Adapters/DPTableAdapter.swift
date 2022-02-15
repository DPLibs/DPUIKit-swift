//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 24.01.2022.
//

import Foundation
import UIKit

open class DPTableAdapter: NSObject {
    
    // MARK: - Init
    public init(sections: [DPTableSectionAdapter] = []) {
        self.sections = sections
        
        super.init()
        self.sectionsDidSet()
    }
    
    // MARK: - Props
    open var sections: [DPTableSectionAdapter] {
        didSet {
            self.sectionsDidSet()
        }
    }
    
    // MARK: - Methods
    func getSection(atIndex index: Int) -> DPTableSectionAdapter? {
        self.sections.getSection(atIndex: index)
    }
    
    open func getSection(at indexPath: IndexPath) -> DPTableSectionAdapter? {
        self.sections.getSection(at: indexPath)
    }
    
    open func sectionsDidSet() {
        self.sections.forEach({ $0.parent = self })
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
        self.sections.getSection(at: indexPath)?.tableView(tableView, cellForRowAt: indexPath) ?? .init()
    }
    
}

#warning("Dev.UITableViewDelegate")
// MARK: - UITableViewDelegate
extension DPTableAdapter: UITableViewDelegate {
    
//    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        #warning("Dev.WillDisplay")
//    }
//
//    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        self.getSection(at: indexPath)?.tableView(tableView, heightForRowAt: indexPath) ?? tableView.rowHeight
//    }
//
//    open func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        self.getSection(at: indexPath)?.tableView(tableView, estimatedHeightForRowAt: indexPath) ?? tableView.estimatedRowHeight
//    }
//
//    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard
//            let section = self.getSection(at: indexPath),
//            let model = section.getRow(at: indexPath),
//            let cell = tableView.cellForRow(at: indexPath)
//        else { return }
//
//        section.tableView(tableView, didSelectRowAt: indexPath)
//    }
//
//    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        self.getSection(atIndex: section)?.tableView(tableView, viewForHeaderInSection: section)
//    }
//
//    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        self.getSection(atIndex: section)?.tableView(tableView, heightForHeaderInSection: section) ?? tableView.sectionHeaderHeight
//    }
//
//    open func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
//        self.getSection(atIndex: section)?.tableView(tableView, estimatedHeightForHeaderInSection: section) ?? tableView.estimatedSectionHeaderHeight
//    }
//
//    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        self.getSection(atIndex: section)?.tableView(tableView, viewForFooterInSection: section)
//    }
//
//    open func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        self.getSection(atIndex: section)?.tableView(tableView, heightForFooterInSection: section) ?? tableView.sectionFooterHeight
//    }
//
//    open func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
//        self.getSection(atIndex: section)?.tableView(tableView, estimatedHeightForFooterInSection: section) ?? tableView.estimatedSectionHeaderHeight
//    }
    
}
