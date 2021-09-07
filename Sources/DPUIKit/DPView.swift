//
//  DPView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPView: UIView, DPViewProtocol {
    
    // MARK: - Model
    open var _model: Any? {
        didSet {
            self.updateComponents()
        }
    }
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
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
    
    open func setHidden(_ hidden: Bool, animated: Bool) {
        guard self.isHidden != hidden else { return }
        
        self.isHidden = hidden
    }
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}

}
