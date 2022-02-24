//
//  DPTableViewHeaderFooterView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableViewHeaderFooterView: UITableViewHeaderFooterView, DPViewProtocol {
    
    // MARK: - Model
    open var _model: Any? {
        didSet {
            self.updateComponents()
        }
    }
    
    // MARK: - Init
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.updateComponents()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupComponents()
    }

    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.setupComponents()
    }

    // MARK: - DPViewProtocol
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}

}
