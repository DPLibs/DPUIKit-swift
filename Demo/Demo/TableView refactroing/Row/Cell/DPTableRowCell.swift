//
//  DPTableRowCell.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit
import DPUIKit

open class DPTableRowCell: UITableViewCell, DPTableRowCellProtocol {
    
    // MARK: - Init
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupComponents()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupComponents()
    }
    
    // MARK: - Props
    open var _model: DPTableRowModelProtocol? {
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
