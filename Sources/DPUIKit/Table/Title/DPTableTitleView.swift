//
//  DPTableTitleView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

/// Protocol for defining a custom [UITableViewHeaderFooterView](https://developer.apple.com/documentation/uikit/uitableviewheaderfooterview).
public protocol DPTableTitleViewProtocol: UITableViewHeaderFooterView {
    
    /// View model.
    /// Set to the cell in the ``DPTableAdapter/tableView(_:viewForHeaderInSection:)`` or ``DPTableAdapter/tableView(_:viewForFooterInSection:)``.
    /// Can also be set by using certain ``DPTableUpdate`` in the ``DPTableAdapter/performBatchUpdates(_:completion:)``.
    var _model: DPRepresentableModel? { get set }
}

/// Basic implementation of the ``DPTableTitleViewProtocol``.
open class DPTableTitleView: UITableViewHeaderFooterView, DPTableTitleViewProtocol, DPViewProtocol {
    
    // MARK: - Init
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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

    // MARK: - DPViewProtocol
    open func setupComponents() {}
    
    open func updateComponents() {}
}
