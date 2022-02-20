//
//  DPTableViewController.swift
//  
//
//  Created by Дмитрий Поляков on 20.01.2022.
//

import Foundation
import UIKit

open class DPTableViewController: DPViewController {
    
    public typealias TableAdapter = UITableViewDataSource & UITableViewDelegate
    
    // MARK: - Props
    open var tableView: DPTableView = .init()
    
    open var adapter: TableAdapter? {
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
    
//    // MARK: - DPTableViewProtocol
//    open var dataSource: UITableViewDataSource? {
//        get { self.tableView.dataSource }
//        set { self.tableView.dataSource = newValue }
//    }
//
//    open var delegate: UITableViewDelegate?
//
//    open var refreshControl: UIRefreshControl?
//
//    open var isRefreshing: Bool
//
//    open func beginRefreshing() {
//        <#code#>
//    }
//
//    open func endRefreshing() {
//        <#code#>
//    }
    
    
    
}
