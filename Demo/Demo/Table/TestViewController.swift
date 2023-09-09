//
//  TestViewController.swift
//  Demo
//
//  Created by Дмитрий Поляков on 09.09.2023.
//

import Foundation
import UIKit
import DPUIKit

class TestViewController: DPViewController {
    
}

open class TableView: UITableView {
    var models: [Any] = [] {
        didSet { self.reloadData() }
    }
    
}

public protocol TableViewCellProtocol: UITableViewCell {
    var _model: Any? { get set }
}

open class TableViewCell: UITableViewCell, TableViewCellProtocol {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    open var _model: Any? {
        didSet { self.updateComponents() }
    }
    
    open func setupComponents() {}
    open func updateComponents() {}
}

open class TableViewCellDataSource<Cell: TableViewCellProtocol, Model>: NSObject, UITableViewDataSource {
    var models: [Any] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.models.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: Cell.self)
        tableView.register(Cell.self, forCellReuseIdentifier: identifier)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let cell = cell as? Cell, self.models.indices.contains(indexPath.row) {
            cell._model = self.models[indexPath.row]
        }
        
        return cell
    }
    
}
 
