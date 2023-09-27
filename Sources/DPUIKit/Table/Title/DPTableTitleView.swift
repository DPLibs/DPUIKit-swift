//
//  DPTableTitleView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

public protocol DPTableTitleViewProtocol: UITableViewHeaderFooterView {
    var _model: DPRepresentableModel? { get set }
}

open class DPTableTitleView: UITableViewHeaderFooterView, DPTableTitleViewProtocol {
    
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
