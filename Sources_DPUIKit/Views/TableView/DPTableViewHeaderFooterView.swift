//
//  DPTableViewHeaderFooterView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableViewHeaderFooterView: UITableViewHeaderFooterView, DPViewProtocol {
    
    // MARK: - Init
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.commonInit()
    }
    
    // MARK: - Props
    open var _model: Any? {
        didSet {
            self.updateComponents()
        }
    }

    // MARK: - DPViewProtocol
    open func commonInit() {
        self.setupComponents()
    }
    
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}

}
