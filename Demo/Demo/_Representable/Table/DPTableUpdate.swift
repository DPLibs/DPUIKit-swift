//
//  DPTableUpdate.swift
//  Demo
//
//  Created by Дмитрий Поляков on 26.09.2023.
//

import Foundation
import UIKit

public struct DPTableUpdate {
    public let perform: (_ adapter: DPTableAdapter) -> Void
}

// MARK: - Store
public extension DPTableUpdate {
    
    // MARK: - Insert - Sections
    static func insertSections(_ sections: [DPTableSectionProtocol], at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, index) in indexSet.enumerated() {
                adapter.sections.insert(sections[offset], at: index)
            }
            
            adapter.tableView?.insertSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Reload - Sections
    static func setSections(_ sections: [DPTableSectionProtocol], at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, index) in indexSet.enumerated() {
                adapter.sections[index] = sections[offset]
            }
            
            adapter.tableView?.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func setSections<S: DPTableSectionProtocol & Identifiable>(_ sections: [S], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            var indicies: [Int] = []
            
            for (sectionOffset, section) in adapter.sections.enumerated() {
                guard let section = section as? S, sections.contains(where: { $0.id == section.id }) else { continue }
                indicies += [sectionOffset]
                adapter.sections[sectionOffset] = section
            }
            
            adapter.tableView?.reloadSections(IndexSet(indicies), with: rowAnimation)
        }
    }
    
    static func reloadSections(at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            adapter.tableView?.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Delete - Sections
    static func deleteSections(at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for index in indexSet {
                adapter.sections.remove(at: index)
            }
            
            adapter.tableView?.deleteSections(indexSet, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func deleteSections<S: DPTableSectionProtocol & Identifiable>(_ sections: [S], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            var indicies: [Int] = []
            
            for (sectionOffset, section) in adapter.sections.enumerated() {
                guard let section = section as? S, sections.contains(where: { $0.id == section.id }) else { continue }
                indicies += [sectionOffset]
            }
            
            guard !indicies.isEmpty else { return }
            let indexSet = IndexSet(indicies)
            
            for index in indexSet {
                adapter.sections.remove(at: index)
            }
            
            adapter.tableView?.deleteSections(indexSet, with: rowAnimation)
        }
    }
    
    // MARK: - Insert - Rows
    static func insertRows(_ rows: [DPRepresentableModel], at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, indexPath) in indexPaths.enumerated() {
                adapter.sections[indexPath.section].rows.insert(rows[offset], at: indexPath.row)
            }
            
            adapter.tableView?.insertRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    // MARK: - Reload - Rows
    static func setRows(_ rows: [DPRepresentableModel], at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, indexPath) in indexPaths.enumerated() {
                adapter.sections[indexPath.section].rows[indexPath.row] = rows[offset]
            }
            
            adapter.tableView?.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func setRows<R: DPRepresentableModel & Identifiable>(_ rows: [R], at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            var indexPaths: [IndexPath] = []
            
            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (rowOffset, row) in section.rows.enumerated() {
                    guard let row = row as? R, rows.contains(where: { $0.id == row.id }) else { continue }
                    indexPaths += [ IndexPath(row: rowOffset, section: sectionOffset) ]
                    adapter.sections[sectionOffset].rows[rowOffset] = row
                }
            }
            
            adapter.tableView?.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    static func reloadRows(at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            adapter.tableView?.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    // MARK: - Delete - Rows
    static func deleteRows(at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for indexPath in indexPaths {
                adapter.sections[indexPath.section].rows.remove(at: indexPath.row)
            }
            
            adapter.tableView?.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    @available(iOS 13.0, *)
    static func deleteRows<R: DPRepresentableModel & Identifiable>(_ rows: [R], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            var indexPaths: [IndexPath] = []
            
            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (rowOffset, row) in section.rows.enumerated() {
                    guard let row = row as? R, rows.contains(where: { $0.id == row.id }) else { continue }
                    indexPaths += [ IndexPath(row: rowOffset, section: sectionOffset) ]
                }
            }
            
            guard !indexPaths.isEmpty else { return }
            
            for indexPath in indexPaths {
                adapter.sections[indexPath.section].rows.remove(at: indexPath.row)
            }
            
            adapter.tableView?.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
}
