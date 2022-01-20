//
//  DPTableViewController.swift
//  
//
//  Created by Дмитрий Поляков on 20.01.2022.
//

import Foundation
import UIKit

open class DPTableViewController: DPViewController, DPTableViewProtocol {
    
    // MARK: - Props
    open var tableView: DPTableView = DPTableView()
    
    open var dataSourceAdapter: DPTableDataSourceAdapter? {
        get { self.dataSource as? DPTableDataSourceAdapter }
        set { self.dataSource = newValue }
    }
    
    open var delegateAdapter: DPTableDelegateAdapter? {
        get { self.delegate as? DPTableDelegateAdapter }
        set { self.delegate = newValue }
    }
    
    // MARK: - DPTableViewProtocol
    open weak var dataSource: UITableViewDataSource? {
        get { self.tableView.dataSource }
        set { self.tableView.dataSource = newValue }
    }
    
    open weak var delegate: UITableViewDelegate? {
        get { self.tableView.delegate }
        set { self.tableView.delegate = newValue }
    }
    
    // MARK: - Methods
    open override func loadView() {
        self.view = self.tableView
    }
    
}
