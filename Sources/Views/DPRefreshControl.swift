//
//  DPRefreshControl.swift
//  
//
//  Created by Дмитрий Поляков on 02.02.2022.
//

import Foundation
import UIKit

open class DPRefreshControl: UIRefreshControl, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    public convenience init(didBeginRefreshing: (() -> Void)?) {
        self.init(frame: .zero)
        
        self.didBeginRefreshing = didBeginRefreshing
        self.commonInit()
    }
    
    // MARK: - Props
    open var didBeginRefreshing: (() -> Void)?
    
    // MARK: - Methods
    open override func beginRefreshing() {
        super.beginRefreshing()
        
        self.didBeginRefreshing?()
    }
    
    @objc
    open func handleValueChanged(_ refreshControl: UIRefreshControl) {
        guard self.isRefreshing else { return }
        self.didBeginRefreshing?()
    }
    
    // MARK: - DPViewProtocol
    public func commonInit() {
        self.setupComponents()
    }
    
    open func setupComponents() {
        self.addTarget(self, action: #selector(self.handleValueChanged(_:)), for: .valueChanged)
    }
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}

// MARK: - UIRefreshControl + DPRefreshControl
public extension UIRefreshControl {
    
    static func refreshControl(didBeginRefreshing: (() -> Void)?) -> DPRefreshControl {
        .init(didBeginRefreshing: didBeginRefreshing)
    }
    
}
