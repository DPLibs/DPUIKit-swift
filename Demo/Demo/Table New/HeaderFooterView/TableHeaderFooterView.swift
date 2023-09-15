//
//  TableHeaderFooterView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

open class TableViewHeaderFooterView: UITableViewHeaderFooterView, TableViewHeaderFooterViewProtocol {
    
    // MARK: - Init
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Props
    open var _model: Any? {
        didSet { self.updateComponents() }
    }
    
    // MARK: - Methods
    open func setupComponents() {}
    open func updateComponents() {}
}
