//
//  DPCollectionSectionProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

public protocol DPCollectionSectionProtocol {
    var items: [DPCollectionItemModelProtocol] { get set }
    var inset: UIEdgeInsets? { get }
}

// MARK: - Default
public extension DPCollectionSectionProtocol {
    
    func item(at index: Int) -> DPCollectionItemModelProtocol? {
        guard self.items.indices.contains(index) else { return nil }
        return self.items[index]
    }
    
}

// MARK: - Array + DPTableSection
public extension Array where Element == DPCollectionSectionProtocol {
    
    func item(at indexPath: IndexPath) -> DPCollectionItemModelProtocol? {
        guard self.indices.contains(indexPath.section) else { return nil }
        return self[indexPath.section].item(at: indexPath.item)
    }
    
    func inset(at index: Int) -> UIEdgeInsets? {
        guard self.indices.contains(index) else { return nil }
        return self[index].inset
    }
    
//    func header(at index: Int) -> DPTableViewHeaderFooterViewModelProtocol? {
//        guard self.indices.contains(index) else { return nil }
//        return self[index].header
//    }
//
//    func footer(at index: Int) -> DPTableViewHeaderFooterViewModelProtocol? {
//        guard self.indices.contains(index) else { return nil }
//        return self[index].footer
//    }
    
}
