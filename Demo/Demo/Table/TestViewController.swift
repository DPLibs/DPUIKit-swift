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
        
        let models = (0...100).map { int in
            TestTableViewCell.Model(
                id: .int(int),
                title: int.description,
                cellAdapter: TableViewCellAdapter(
                    onCellForRow: { ctx in
                        print("!!!", ctx)
//                        guard let _model
                    }
                )
            )
        }
        
        self.tableView.reloadRows(models)
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
    
    struct Model: TableViewCellModelProtocol {
        let id: TableUUID
        let cellClass: AnyClass = TestTableViewCell.self

        let title: String
        var cellAdapter: TableViewCellAdapterProtocol?
    }
    
}
