//
//  DPTableCellAdapter.swift
//  
//
//  Created by Дмитрий Поляков on 15.02.2022.
//

import Foundation
import UIKit

//public typealias DPTableCellContext = (indexPath: IndexPath, cell: DPTableViewCell, model: DPTableRowModel)

public protocol DPTableCellAdapterProtocol {
    var cellClass: UITableViewCell.Type { get }
    var cellIdentifier: String { get }
    
    func cellForRow(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
}

open class DPTableCellAdapter<CellType: DPTableCellProtocol>: DPTableCellAdapterProtocol {
    public var didSelectCell: ((CellType) -> Void)?
    
    public typealias DPTableCellContext = (cell: CellType, indexPath: IndexPath)
    public typealias DPTableCellContextClosure = (DPTableCellContext) -> Void
    
    // MARK: - Init
    public init() {}
    
    public init(didCellForRow: ((DPTableCellContext) -> Void)?) {
        self.didCellForRow = didCellForRow
    }
    
    // MARK: - Props
//    internal weak var cell: UITableViewCell?
    internal weak var sectionAdapter: DPTableSectionAdapter?
    
    open var cellClass: UITableViewCell.Type {
        CellType.self
    }
    
    open var cellIdentifier: String {
        String(describing: cellClass.self)
    }
    
    open var rowHeight: CGFloat = UITableView.automaticDimension
    open var estimatedRowHeight: CGFloat = 50
    
    open var didCellForRow: DPTableCellContextClosure?
    open var willCellDisplay: DPTableCellContextClosure?
    
    open func cellForRow(_ tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        tableView.registerCellClasses([ CellType.self ])
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CellType else { return .init() }
        
        self.didCellForRow?((cell, indexPath))
        
        return cell
    }
    
//    open var model: CellModelType
    
    // MARK: - Methods
//    open func leadingSwipeActionsConfiguration(for context: DPTableCellContext) -> UISwipeActionsConfiguration? {
//        .empty
//    }
//    
//    open func trailingSwipeActionsConfiguration(for context: DPTableCellContext) -> UISwipeActionsConfiguration? {
//        .empty
//    }
//    
//    open func willBeginEditing(for cell: UITableViewCell) { }
//    
//    open func didEndEditing(for cell: UITableViewCell) { }
//    
}

//public protocol DPTableCellModelProtocol {}
//
//public protocol DPTableCellProtocol: UITableViewCell {
//    associatedtype CellModelType = DPTableCellModelProtocol
//
//    var model: CellModelType? { get set }
//}
//
//open class DPTableCell<Model: DPTableCellModelProtocol>: UITableViewCell, DPTableCellProtocol {
//    open var model: Model?
//}

public protocol DPTableCellProtocol: UITableViewCell {
//    var cellAdapter: DPTableCellAdapterProtocol? { get set }
}

open class DPTableCell: UITableViewCell, DPTableCellProtocol {
//    open var cellAdapter: DPTableCellAdapterProtocol?
    
//    public var cellAdapter: DPTableCellAdapter<DPTableCell>?
    
    
}


//class A {
//    let adapters: [DPTableCellAdapterProtocol]
//
//    init() {
//        self.adapters = [
//            DPTableCellAdapter<DPTableCell>()
//        ]
//    }
//
//    func ttt() {
//        let cell = UITableViewCell()
//        let adapter: DPTableCellAdapterProtocol = DPTableCellAdapter<DPTableCell>()
//
//        let cellCast = adapter.dequeueCell(inTable: .init(), at: nil)
//
////        cellCast
////        guard let cellCast = cell as? adapter.cellClass.Type else { return }
//    }
//}
