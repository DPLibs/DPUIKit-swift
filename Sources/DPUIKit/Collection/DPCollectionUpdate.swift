//
//  DPCollectionUpdate.swift
//  Demo
//
//  Created by Дмитрий Поляков on 03.10.2023.
//

import Foundation
import UIKit

/// Component for updating ``DPCollectionView`` data and ``DPCollectionAdapter/sections``.
public struct DPCollectionUpdate {
    
    /// A closure to update ``DPCollectionView`` data and ``DPCollectionAdapter/sections``.
    public let perform: (_ adapter: DPCollectionAdapter) -> Void
}

// MARK: - Store
public extension DPCollectionUpdate {
    
    /// Adds new sections.
    ///
    /// - Parameter sections: array of sections for installation.
    /// - Parameter indexSet: numbers in the ``DPCollectionAdapter/sections`` for installation.
    static func insertSections(_ sections: [DPCollectionSectionType], at indexSet: IndexSet) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            for (offset, index) in indexSet.enumerated() {
                adapter.sections.insert(sections[offset], at: index)
            }

            adapter.collectionView?.insertSections(indexSet)
        }
    }

    /// Set new sections at `indexSet`.
    ///
    /// - Parameter sections: array of sections for installation.
    /// - Parameter indexSet: numbers in the ``DPCollectionAdapter/sections`` for installation.
    static func setSections(_ sections: [DPCollectionSectionType], at indexSet: IndexSet) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            for (offset, index) in indexSet.enumerated() {
                adapter.sections[index] = sections[offset]
            }

            adapter.collectionView?.reloadSections(indexSet)
        }
    }
    
    /// Set new sections by `Equatable`.
    ///
    /// - Parameter sections: array of sections for installation.
    static func setSections<S: DPCollectionSectionType & Equatable>(_ sections: [S]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indicies: [Int] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                guard let section = section as? S, let newSection = sections.first(where: { $0 == section }) else { continue }
                indicies += [sectionOffset]
                adapter.sections[sectionOffset] = newSection
            }

            adapter.collectionView?.reloadSections(IndexSet(indicies))
        }
    }

    /// Set new sections by `Identifiable`.
    ///
    /// - Parameter sections: array of sections for installation.
    @available(iOS 13.0, *)
    static func setSections<S: DPCollectionSectionType & Identifiable>(identified sections: [S]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indicies: [Int] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                guard let section = section as? S, let newSection = sections.first(where: { $0.id == section.id }) else { continue }
                indicies += [sectionOffset]
                adapter.sections[sectionOffset] = newSection
            }

            adapter.collectionView?.reloadSections(IndexSet(indicies))
        }
    }

    /// Reload sections.
    ///
    /// - Parameter indexSet: numbers in the ``DPCollectionAdapter/sections`` for reload.
    static func reloadSections(at indexSet: IndexSet) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            adapter.collectionView?.reloadSections(indexSet)
        }
    }

    /// Delete sections at `indexSet`.
    ///
    /// - Parameter indexSet: numbers in the ``DPCollectionAdapter/sections`` for delete.
    static func deleteSections(at indexSet: IndexSet) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            for index in indexSet {
                adapter.sections.remove(at: index)
            }

            adapter.collectionView?.deleteSections(indexSet)
        }
    }
    
    /// Delete sections by `Equatable`.
    ///
    /// - Parameter sections: array of sections for delete.
    static func deleteSections<S: DPCollectionSectionType & Equatable>(_ sections: [S], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indicies: [Int] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                guard let section = section as? S, sections.contains(where: { $0 == section }) else { continue }
                indicies += [sectionOffset]
            }

            guard !indicies.isEmpty else { return }
            let indexSet = IndexSet(indicies)

            for index in indexSet {
                adapter.sections.remove(at: index)
            }

            adapter.collectionView?.deleteSections(indexSet)
        }
    }

    /// Delete sections by `Identifiable`.
    ///
    /// - Parameter sections: array of sections for delete.
    @available(iOS 13.0, *)
    static func deleteSections<S: DPCollectionSectionType & Identifiable>(identified sections: [S], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
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

            adapter.collectionView?.deleteSections(indexSet)
        }
    }
    
    /// Delete sections by `ID`.
    ///
    /// - Parameter sections: array of sections for delete.
    @available(iOS 13.0, *)
    static func deleteSections<ID: Equatable>(ids: [ID], with rowAnimation: UITableView.RowAnimation = .automatic) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indicies: [Int] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                guard let section = section as? (any Identifiable), let id = section.id as? ID, ids.contains(id) else { continue }
                indicies += [sectionOffset]
            }

            guard !indicies.isEmpty else { return }
            let indexSet = IndexSet(indicies)

            for index in indexSet {
                adapter.sections.remove(at: index)
            }

            adapter.collectionView?.deleteSections(indexSet)
        }
    }

    /// Adds new items.
    ///
    /// - Parameter items: array of items for installation.
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPCollectionAdapter/sections`` for installation.
    static func insertItems(_ items: [Sendable], at indexPaths: [IndexPath]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            for (offset, indexPath) in indexPaths.enumerated() {
                adapter.sections[indexPath.section].items.insert(items[offset], at: indexPath.item)
            }

            adapter.collectionView?.insertItems(at: indexPaths)
        }
    }

    /// Set new items at `indexPaths`.
    ///
    /// - Parameter rows: array of items for installation.
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPCollectionAdapter/sections`` for installation.
    /// - Parameter rowAnimation: animation type.
    static func setItems(_ items: [Sendable], at indexPaths: [IndexPath]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            for (offset, indexPath) in indexPaths.enumerated() {
                adapter.sections[indexPath.section].items[indexPath.item] = items[offset]
            }

            adapter.collectionView?.reloadItems(at: indexPaths)
        }
    }
    
    /// Set new items by `Equatable`.
    ///
    /// - Parameter items: array of items for installation.
    static func setItems<I: Sendable & Equatable>(_ items: [I]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indexPaths: [IndexPath] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (itemOffset, item) in section.items.enumerated() {
                    guard let item = item as? I, let newItem = items.first(where: { $0 == item }) else { continue }
                    indexPaths += [ IndexPath(item: itemOffset, section: sectionOffset) ]
                    adapter.sections[sectionOffset].items[itemOffset] = newItem
                }
            }

            adapter.collectionView?.reloadItems(at: indexPaths)
        }
    }

    /// Set new items by `Identifiable`.
    ///
    /// - Parameter items: array of items for installation.
    @available(iOS 13.0, *)
    static func setItems<I: Sendable & Identifiable>(identified items: [I]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indexPaths: [IndexPath] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (itemOffset, item) in section.items.enumerated() {
                    guard let item = item as? I, let newItem = items.first(where: { $0.id == item.id }) else { continue }
                    indexPaths += [ IndexPath(item: itemOffset, section: sectionOffset) ]
                    adapter.sections[sectionOffset].items[itemOffset] = newItem
                }
            }

            adapter.collectionView?.reloadItems(at: indexPaths)
        }
    }

    /// Reload items.
    ///
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPCollectionAdapter/sections`` for installation.
    static func reloadItems(at indexPaths: [IndexPath]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            adapter.collectionView?.reloadItems(at: indexPaths)
        }
    }

    /// Delete items at `indexPaths`.
    ///
    /// - Parameter indexPaths: array of [IndexPath](https://developer.apple.com/documentation/foundation/indexpath) in the ``DPCollectionAdapter/sections`` for installation.
    static func deleteItems(at indexPaths: [IndexPath]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            for indexPath in indexPaths {
                adapter.sections[indexPath.section].items.remove(at: indexPath.item)
            }

            adapter.collectionView?.deleteItems(at: indexPaths)
        }
    }
    
    /// Delete items by `Equatable`.
    ///
    /// - Parameter sections: array of items for delete.
    static func deleteItems<I: Sendable & Equatable>(_ items: [I]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indexPaths: [IndexPath] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (itemOffset, item) in section.items.enumerated() {
                    guard let item = item as? I, items.contains(where: { $0 == item }) else { continue }
                    indexPaths += [ IndexPath(row: itemOffset, section: sectionOffset) ]
                }
            }

            guard !indexPaths.isEmpty else { return }

            for indexPath in indexPaths {
                adapter.sections[indexPath.section].items.remove(at: indexPath.row)
            }

            adapter.collectionView?.deleteItems(at: indexPaths)
        }
    }

    /// Delete items by `Identifiable`.
    ///
    /// - Parameter sections: array of items for delete.
    @available(iOS 13.0, *)
    static func deleteItems<I: Sendable & Identifiable>(identified items: [I]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indexPaths: [IndexPath] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (itemOffset, item) in section.items.enumerated() {
                    guard let item = item as? I, items.contains(where: { $0.id == item.id }) else { continue }
                    indexPaths += [ IndexPath(row: itemOffset, section: sectionOffset) ]
                }
            }

            guard !indexPaths.isEmpty else { return }

            for indexPath in indexPaths {
                adapter.sections[indexPath.section].items.remove(at: indexPath.row)
            }

            adapter.collectionView?.deleteItems(at: indexPaths)
        }
    }
    
    /// Delete items by `ID`.
    ///
    /// - Parameter sections: array of items for delete.
    @available(iOS 13.0, *)
    static func deleteItems<ID: Equatable>(ids: [ID]) -> DPCollectionUpdate {
        DPCollectionUpdate { adapter in
            var indexPaths: [IndexPath] = []

            for (sectionOffset, section) in adapter.sections.enumerated() {
                for (itemOffset, item) in section.items.enumerated() {
                    guard let item = item as? (any Identifiable), let id = item.id as? ID, ids.contains(id) else { continue }
                    indexPaths += [ IndexPath(row: itemOffset, section: sectionOffset) ]
                }
            }

            guard !indexPaths.isEmpty else { return }

            for indexPath in indexPaths {
                adapter.sections[indexPath.section].items.remove(at: indexPath.row)
            }

            adapter.collectionView?.deleteItems(at: indexPaths)
        }
    }
    
}
