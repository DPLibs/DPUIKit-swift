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
    
    private lazy var tableView = TableView()
    
    override func loadView() {
        self.view = self.tableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.adapter = TableViewAdapter()
        
        DispatchQueue.global().async {
            let rows = (0...1_000).map { int in
                return TestTableViewCell.Model(title: int.description)
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadRows(rows)
            }
        }
    }
    
}

class TestTableViewCell: TableViewCell {
    
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    let label = UILabel().applyStyles(.textColor(.black))
    
    override func setupComponents() {
        super.setupComponents()
        
        self.label.addToSuperview(self.contentView, withConstraints: [ .edges() ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.label.text = self.model?.title
    }
    
}

extension TestTableViewCell {
    
//    typealias Adapter = TableViewCellAdapter<TestTableViewCell, Model>
    
    struct Model: TableViewCellModelProtocol {
        let cellClass: TableViewCellProtocol.Type = TestTableViewCell.self
        
        init(title: String) {
            self.title = title
        }
        
        let title: String
    }
    
}
