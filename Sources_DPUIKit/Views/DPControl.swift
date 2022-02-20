//
//  DPControl.swift
//  
//
//  Created by Дмитрий Поляков on 25.10.2021.
//

import Foundation
import UIKit

open class DPControl: UIControl, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    // MARK: - Methods
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
 
