//
//  TableView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

open class TableView: UITableView {
    
    open var adapter: TableViewAdapterProtocol? {
        didSet {
            self.delegate = self.adapter
            self.dataSource = self.adapter
        }
    }
    
    open func reloadData(_ sections: [TableViewSectionProtocol]) {
        self.adapter?.sections = sections
        self.reloadData()
    }
    
    open func reloadData(_ models: [TableViewCellModelProtocol]) {
        self.adapter?.sections = [ TableViewSection(models: models) ]
        self.reloadData()
    }
    
}
