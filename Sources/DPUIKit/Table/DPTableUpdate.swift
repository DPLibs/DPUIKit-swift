//
//  DPTableUpdate.swift
//  Demo
//
//  Created by Дмитрий Поляков on 26.09.2023.
//

import Foundation
import UIKit

/// Component for updating ``DPTableView`` data and ``DPTableAdapter/sections``.
public struct DPTableUpdate {
    
    /// A closure to update ``DPTableView`` data and ``DPTableAdapter/sections``.
    public let perform: (_ adapter: DPTableAdapter) -> Void
}

// MARK: - Store
public extension DPTableUpdate {
    
    /// Adds new sections.
    ///
    /// - Parameter sections: array of sections for installation.
    /// - Parameter indexSet: numbers in the ``DPTableAdapter/sections`` for installation.
    /// - Parameter rowAnimation: animation type.
    static func insertSections(_ sections: [DPRepresentableSectionType], at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, index) in indexSet.enumerated() {
                adapter.sections.insert(sections[offset], at: index)
            }
            
            adapter.tableView?.insertSections(indexSet, with: rowAnimation)
        }
    }
    
    /// Set new sections at `indexSet`.
    ///
    /// - Parameter sections: array of sections for installation.
    /// - Parameter indexSet: numbers in the ``DPTableAdapter/sections`` for installation.
    /// - Parameter rowAnimation: animation type.
    static func setSections(_ sections: [DPRepresentableSectionType], at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, index) in indexSet.enumerated() {
                adapter.sections[index] = sections[offset]
            }
            
            adapter.tableView?.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    /// Set new sections by `ID`.
    ///
    /// - Parameter sections: array of sections for installation.
    /// - Parameter rowAnimation: animation type.
    @available(iOS 13.0, *)
    static func setSections<S: DPRepresentableSectionType & Identifiable>(_ sections: [S], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
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
    
    /// Reload sections.
    ///
    /// - Parameter indexSet: numbers in the ``DPTableAdapter/sections`` for reload.
    /// - Parameter rowAnimation: animation type.
    static func reloadSections(at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            adapter.tableView?.reloadSections(indexSet, with: rowAnimation)
        }
    }
    
    /// Delete sections at `indexSet`.
    ///
    /// - Parameter indexSet: numbers in the ``DPTableAdapter/sections`` for delete.
    /// - Parameter rowAnimation: animation type.
    static func deleteSections(at indexSet: IndexSet, with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for index in indexSet {
                adapter.sections.remove(at: index)
            }
            
            adapter.tableView?.deleteSections(indexSet, with: rowAnimation)
        }
    }
    
    /// Delete sections by `ID`.
    ///
    /// - Parameter sections: array of sections for delete.
    /// - Parameter rowAnimation: animation type.
    @available(iOS 13.0, *)
    static func deleteSections<S: DPRepresentableSectionType & Identifiable>(_ sections: [S], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
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
    
    /// Adds new rows.
    ///
    /// - Parameter rows: array of rows for installation.
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPTableAdapter/sections`` for installation.
    /// - Parameter rowAnimation: animation type.
    static func insertRows(_ rows: [DPAnyRepresentable], at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, indexPath) in indexPaths.enumerated() {
                adapter.sections[indexPath.section].items.insert(rows[offset], at: indexPath.row)
            }
            
            adapter.tableView?.insertRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    /// Set new rows at `indexPaths`.
    ///
    /// - Parameter rows: array of rows for installation.
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPTableAdapter/sections`` for installation.
    /// - Parameter rowAnimation: animation type.
    static func setRows(_ rows: [DPAnyRepresentable], at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for (offset, indexPath) in indexPaths.enumerated() {
                adapter.sections[indexPath.section].items[indexPath.row] = rows[offset]
            }
            
            adapter.tableView?.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    /// Set new rows by `ID`.
    ///
    /// - Parameter rows: array of rows for installation.
    /// - Parameter rowAnimation: animation type.
    @available(iOS 13.0, *)
    static func setRows<R: DPRepresentable & Identifiable>(_ rows: [R],with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            var indexPaths: [IndexPath] = []
            
            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (rowOffset, row) in section.items.enumerated() {
                    guard let row = row as? R, rows.contains(where: { $0.id == row.id }) else { continue }
                    indexPaths += [ IndexPath(row: rowOffset, section: sectionOffset) ]
                    adapter.sections[sectionOffset].items[rowOffset] = row
                }
            }
            
            adapter.tableView?.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    /// Reload rows.
    ///
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPTableAdapter/sections`` for installation.
    /// - Parameter rowAnimation: animation type.
    static func reloadRows(at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            adapter.tableView?.reloadRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    /// Delete rows at `indexPaths`.
    ///
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPTableAdapter/sections`` for installation.
    /// - Parameter rowAnimation: animation type.
    static func deleteRows(at indexPaths: [IndexPath], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            for indexPath in indexPaths {
                adapter.sections[indexPath.section].items.remove(at: indexPath.row)
            }
            
            adapter.tableView?.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    /// Delete rows by `ID`.
    ///
    /// - Parameter sections: array of rows for delete.
    /// - Parameter rowAnimation: animation type.
    @available(iOS 13.0, *)
    static func deleteRows<R: DPRepresentable & Identifiable>(_ rows: [R], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            var indexPaths: [IndexPath] = []
            
            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (rowOffset, row) in section.items.enumerated() {
                    guard let row = row as? R, rows.contains(where: { $0.id == row.id }) else { continue }
                    indexPaths += [ IndexPath(row: rowOffset, section: sectionOffset) ]
                }
            }
            
            guard !indexPaths.isEmpty else { return }
            
            for indexPath in indexPaths {
                adapter.sections[indexPath.section].items.remove(at: indexPath.row)
            }
            
            adapter.tableView?.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
    /// Delete rows by `ID`.
    ///
    /// - Parameter ids: array of models ids for delete.
    /// - Parameter rowAnimation: animation type.
    @available(iOS 13.0, *)
    static func deleteRows<ID: Equatable>(_ ids: [ID], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPTableUpdate {
        DPTableUpdate { adapter in
            var indexPaths: [IndexPath] = []
            
            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (rowOffset, row) in section.items.enumerated() {
                    guard let row = row as? (any Identifiable), let id = row.id as? ID, ids.contains(id) else { continue }
                    indexPaths += [ IndexPath(row: rowOffset, section: sectionOffset) ]
                }
            }
            
            guard !indexPaths.isEmpty else { return }
            
            for indexPath in indexPaths {
                adapter.sections[indexPath.section].items.remove(at: indexPath.row)
            }
            
            adapter.tableView?.deleteRows(at: indexPaths, with: rowAnimation)
        }
    }
    
}
