//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 03.11.2021.
//

import Foundation
import UIKit

open class DPSwitch: UISwitch, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupComponents()
    }
    
    // MARK: - Props
    open var didTap: (() -> Void)? {
        didSet {
            self.addTarget(self, action: #selector(self.handleTap), for: .touchUpInside)
        }
    }
    
    // MARK: - Methods
    open func setupComponents() {}
    
    open func updateComponents() { }
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
    @objc
    open func handleTap() {
        self.didTap?()
    }
    
}
