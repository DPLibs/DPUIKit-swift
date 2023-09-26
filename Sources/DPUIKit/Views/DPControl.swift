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
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Methods
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
}
 
