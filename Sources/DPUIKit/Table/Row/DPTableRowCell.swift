//
//  DPTableRowCell.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

/// Protocol for defining a custom [UITableViewCell](https://developer.apple.com/documentation/uikit/uitableviewcell).
public protocol DPTableRowCellType: UITableViewCell {
    
    /// Cell model.
    /// Set to the cell in the ``DPTableAdapter/tableView(_:cellForRowAt:)``.
    /// Can also be set by using certain ``DPTableUpdate`` in the ``DPTableAdapter/performBatchUpdates(_:completion:)``.
    var _model: DPRepresentableModel? { get set }
}

/// Basic implementation of the ``DPTableRowCellType``.
open class DPTableRowCell: UITableViewCell, DPTableRowCellType, DPViewProtocol {
    
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
    open var _model: DPRepresentableModel? {
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
