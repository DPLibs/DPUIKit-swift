//
//  DPTableViewHeaderFooterView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableViewHeaderFooterView: UITableViewHeaderFooterView, DPTableViewHeaderFooterViewProtocol {
    
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
    open var _model: DPTableViewHeaderFooterViewModelProtocol? {
        didSet { self.updateComponents() }
    }

    // MARK: - DPViewProtocol
    open func setupComponents() {}
    
    open func updateComponents() {}
}
