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
    
    public init(didTouchUpInside: (() -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.didTouchUpInside = didTouchUpInside
        self.didTouchUpInsideDidSet()
    }
    
    // MARK: - Props
    open var didTouchUpInside: (() -> Void)? {
        didSet { self.didTouchUpInsideDidSet() }
    }
    
    // MARK: - Methods
    open func setupComponents() {}
    
    open func updateComponents() { }
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    open func didTouchUpInsideDidSet() {
        if self.didTouchUpInside == nil {
            self.removeTarget(self, action: #selector(self.handleTouchUpInside), for: .touchUpInside)
        } else {
            self.addTarget(self, action: #selector(self.handleTouchUpInside), for: .touchUpInside)
        }
    }
    
    @objc
    open func handleTouchUpInside() {
        self.didTouchUpInside?()
    }
    
}
