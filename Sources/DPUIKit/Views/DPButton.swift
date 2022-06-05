//
//  DPButton.swift
//
//
//  Created by Дмитрий Поляков on 25.10.2021.
//

import Foundation
import UIKit

open class DPButton: UIButton, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupComponents()
    }
    
    public convenience init(type: UIButton.ButtonType, didTouchUpInside: (() -> Void)? = nil) {
        self.init(type: type)
        
        self.didTouchUpInside = didTouchUpInside
        self.didTouchUpInsideDidSet()
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
    
    open func updateComponents() {}
    
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
