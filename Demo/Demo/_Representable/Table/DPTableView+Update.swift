//
//  DPTableView+Update.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

public extension DPTableView {
    
    // MARK: - Static
    struct Update {
        fileprivate let perform: (_ tableView: DPTableView) -> Void
    }
    
    // MARK: - Methods
    func performBatchUpdates(withUpdates updates: [Update]?, completion: ((Bool) -> Void)? = nil) {
        self.performBatchUpdates({ [weak self] in
            guard let self = self else { return }
            (updates ?? []).forEach({ $0.perform(self) })
        }, completion: completion)
    }
    
}

// MARK: - DPTableView.Update + Store
public extension DPTableView.Update {
    
    // MARK: - Insert - Sections
    static func insertSections(_ sections: [DPTableSectionProtocol], at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            for (offset, index) in indexSet.enumerated() {
                tableView.sections.insert(sections[offset], at: index)
            }
            
            tableView.insertSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Reload - Sections
    static func reloadSections(newSections sections: [DPTableSectionProtocol], at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            for (offset, index) in indexSet.enumerated() {
                tableView.sections[index] = sections[offset]
            }
            
            tableView.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    static func reloadSections(at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            tableView.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Delete - Sections
    static func deleteSections(at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            for index in indexSet {
                tableView.sections.remove(at: index)
            }
            
            tableView.deleteSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Insert - Rows
    static func insertRows(_ rows: [DPRepresentableModel], at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            for (offset, indexPath) in indexPaths.enumerated() {
                tableView.sections[indexPath.section].rows.insert(rows[offset], at: indexPath.row)
            }
            
            tableView.insertRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    // MARK: - Reload - Rows
    static func reloadRows(newRows rows: [DPRepresentableModel], at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            for (offset, indexPath) in indexPaths.enumerated() {
                tableView.sections[indexPath.section].rows[indexPath.row] = rows[offset]
            }
            
            tableView.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    static func reloadRows(at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            tableView.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    // MARK: - Delete - Rows
    static func deleteRows(at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation) -> Self {
        .init { tableView in
            for indexPath in indexPaths {
                tableView.sections[indexPath.section].rows.remove(at: indexPath.row)
            }
            
            tableView.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
}
