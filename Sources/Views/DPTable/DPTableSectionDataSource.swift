//
//  DPTableSectionDataSource.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableSectionDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Props
    open var rows: [DPTableRowModel] = []
    open var header: DPTableSectionHeaderModel?
    open var footer: DPTableSectionHeaderModel?

    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.rows.indices.contains(indexPath.row) else { return .init() }
        let row = self.rows[indexPath.row]
        
        guard
            let cellIdentifier = row.cellIdentifier,
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DPTableViewCell
        else { return .init() }

        cell._model = row
        return cell
    }

}

open class DPTableDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Props
    open var sections: [DPTableSectionDataSource] = []

    // MARK: - UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return 0 }
        return self.sections[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.sections.indices.contains(indexPath.section) else { return .init() }
        return self.sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }

}

//open class DPTableDataSourceAdapter: NSObject, UITableViewDataSource {
//    
//    // MARK: - Props
//    open weak var tableView: DPTableView? {
//        didSet {
//            self.tableView?.dataSource = self
//        }
//    }
//    
//    open var sections: [DPTableSectionModel] {
//        get {
//            self.tableView?.sections ?? []
//        }
//        set {
//            self.tableView?.sections = newValue
//        }
//    }
//    
//    // MARK: - UITableViewDataSource
//    open func numberOfSections(in tableView: UITableView) -> Int {
//        self.sections.count
//    }
//
//    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        guard self.sections.indices.contains(section) else { return .zero }
//        
//        return self.sections[section].rows.count
//    }
//
//    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard
//            let row = self.sections.getRow(at: indexPath),
//            let cellIdentifier = row.cellIdentifier,
//            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DPTableViewCell
//        else { return .init() }
//
//        cell._model = row
//        
//        if let tableView = self.tableView {
//            tableView.cellsOutput?.cellForRow(tableView, indexPath: indexPath, cell: cell)
//        }
//
//        return cell
//    }
//    
//}
