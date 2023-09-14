//
//  TableView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

open class TableView: UITableView {
    
    // MARK: - Props
    open var adapter: TableViewAdapterProtocol? {
        didSet {
            self.delegate = self.adapter
            self.dataSource = self.adapter
        }
    }
    
    open var sections: [TableViewSectionProtocol] {
        get { self.adapter?.sections ?? [] }
        set { self.adapter?.sections = newValue }
    }
    
    // MARK: - Methods
    open func reloadSections(_ sections: [TableViewSectionProtocol]) {
        self.adapter?.sections = sections
        self.reloadData()
    }
    
    open func reloadRows(_ rows: [TableViewCellModelProtocol]) {
        self.adapter?.sections = [ TableViewSection(models: rows) ]
        self.reloadData()
    }
    
    // MARK: - Update
    public struct Update {
        public let perform: (_ tableView: TableView) -> Void
    }
    
    open func performBatchUpdates(_ updates: [Update]?, completion: ((Bool) -> Void)? = nil) {
        self.performBatchUpdates(
            { [weak self] in
                guard let self else { return }
                (updates ?? []).forEach({ $0.perform(self) })
            },
            completion: completion
        )
    }
    
    @available(iOS 13.0, *)
    open func scrollToRow<R: TableViewCellModelProtocol & Identifiable>(_ row: R, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        let indexPath: IndexPath? = {
            for (sectionOffset, section) in self.sections.enumerated() {
                for (rowOffset, _row) in section.models.enumerated() where (_row as? R)?.id == row.id {
                    return IndexPath(row: rowOffset, section: sectionOffset)
                }
            }
            return nil
        }()
        
        guard let indexPath else { return }
        self.scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }
    
}

// MARK: - Updates
public extension TableView.Update {
    
    // MARK: - Insert - Sections
    static func insertSections(
        _ sections: [TableViewSectionProtocol],
        at indexSet: IndexSet,
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            for (offset, index) in indexSet.enumerated() {
                tableView.sections.insert(sections[offset], at: index)
            }
            
            tableView.insertSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Set - Sections
    static func setSections(
        _ sections: [TableViewSectionProtocol],
        at indexSet: IndexSet,
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            for (offset, index) in indexSet.enumerated() {
                tableView.sections[index] = sections[offset]
            }
            
            tableView.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func setSections<S: TableViewSectionProtocol & Identifiable>(
        _ sections: [S],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            let indicies: [Int] = sections.compactMap { findSection in
                for (sectionOffset, section) in tableView.sections.enumerated() where (section as? S)?.id == findSection.id {
                    return sectionOffset
                }
                return nil
            }
            
            guard !indicies.isEmpty else { return }
            let indexSet = IndexSet(indicies)
            
            for (offset, index) in indexSet.enumerated() {
                tableView.sections[index] = sections[offset]
            }
            
            tableView.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Reload - Sections
    static func reloadSections(
        at indexSet: IndexSet,
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            tableView.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Delete - Sections
    static func deleteSections(
        at indexSet: IndexSet,
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            for index in indexSet {
                tableView.sections.remove(at: index)
            }
            
            tableView.deleteSections(indexSet, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func deleteSections<S: TableViewSectionProtocol & Identifiable>(
        _ sections: [S],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            let indicies: [Int] = sections.compactMap { findSection in
                for (sectionOffset, section) in tableView.sections.enumerated() where (section as? S)?.id == findSection.id {
                    return sectionOffset
                }
                return nil
            }
            
            guard !indicies.isEmpty else { return }
            let indexSet = IndexSet(indicies)
            
            for index in indexSet {
                tableView.sections.remove(at: index)
            }

            tableView.deleteSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Insert - Rows
    static func insertRows(
        _ rows: [TableViewCellModelProtocol],
        at indexPaths: [IndexPath],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            for (offset, indexPath) in indexPaths.enumerated() {
                tableView.sections[indexPath.section].models.insert(rows[offset], at: indexPath.row)
            }
            
            tableView.insertRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    // MARK: - Set - Rows
    static func setRows(
        _ rows: [TableViewCellModelProtocol],
        at indexPaths: [IndexPath],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            for (offset, indexPath) in indexPaths.enumerated() {
                tableView.sections[indexPath.section].models[indexPath.row] = rows[offset]
            }
            
            tableView.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func setRows<R: TableViewCellModelProtocol & Identifiable>(
        _ rows: [R],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            let indexPaths: [IndexPath] = rows.compactMap { findRow in
                for (sectionOffset, section) in tableView.sections.enumerated() {
                    for (rowOffset, row) in section.models.enumerated() where (row as? R)?.id == findRow.id {
                        return IndexPath(row: rowOffset, section: sectionOffset)
                    }
                }
                return nil
            }
            
            guard !indexPaths.isEmpty else { return }
            
            for (offset, indexPath) in indexPaths.enumerated() {
                tableView.sections[indexPath.section].models[indexPath.row] = rows[offset]
            }
            
            tableView.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    // MARK: - Reload - Rows
    static func reloadRows(
        at indexPaths: [IndexPath],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            tableView.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    // MARK: - Delete - Rows
    static func deleteRows(
        at indexPaths: [IndexPath],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            for indexPath in indexPaths {
                tableView.sections[indexPath.section].models.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func deleteRows<R: TableViewCellModelProtocol & Identifiable>(
        _ rows: [R],
        with rowAnimation: UITableView.RowAnimation
    ) -> TableView.Update {
        TableView.Update { tableView in
            let indexPaths: [IndexPath] = rows.compactMap { findRow in
                for (sectionOffset, section) in tableView.sections.enumerated() {
                    for (rowOffset, row) in section.models.enumerated() where (row as? R)?.id == findRow.id {
                        return IndexPath(row: rowOffset, section: sectionOffset)
                    }
                }
                return nil
            }
            
            guard !indexPaths.isEmpty else { return }
            
            for indexPath in indexPaths {
                tableView.sections[indexPath.section].models.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
}
