//
//  TableViewCell.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

open class TableViewCell: UITableViewCell, TableViewCellProtocol {
    
    // MARK: - Init
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Props
    open var _model: TableViewCellModelProtocol? {
        didSet { self.updateComponents() }
    }
    
    // MARK: - Methods
    open func setupComponents() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    open func updateComponents() {}
}
