//
//  DPTableViewController.swift
//  
//
//  Created by Дмитрий Поляков on 20.01.2022.
//

import Foundation
import UIKit

open class DPTableViewController: DPViewController {
    
    // MARK: - Props
    open var tableView: DPTableView = .init()
    
    open var adapter: DPTableAdapterProtocol? {
        didSet {
            self.adapterDidSet()
        }
    }
    
//    open var dataSourceAdapter: DPTableDataSourceAdapter? {
//        get { self.dataSource as? DPTableDataSourceAdapter }
//        set { self.dataSource = newValue }
//    }
//
//    open var delegateAdapter: DPTableDelegateAdapter? {
//        get { self.delegate as? DPTableDelegateAdapter }
//        set { self.delegate = newValue }
//    }
//
//    // MARK: - DPTableViewProtocol
//    open weak var dataSource: UITableViewDataSource? {
//        get { self.tableView.dataSource }
//        set { self.tableView.dataSource = newValue }
//    }
//
//    open weak var delegate: UITableViewDelegate? {
//        get { self.tableView.delegate }
//        set { self.tableView.delegate = newValue }
//    }
    
    // MARK: - Methods
    open override func loadView() {
        self.view = self.tableView
    }
    
    open override func setupComponents() {
        super.setupComponents()
        
        self.adapterDidSet()
    }
    
    open func adapterDidSet() {
        self.tableView.delegate = self.adapter
        self.tableView.dataSource = self.adapter
    }
    
}
