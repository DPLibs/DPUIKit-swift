//
//  DPRefreshControl.swift
//  
//
//  Created by Дмитрий Поляков on 02.02.2022.
//

import Foundation
import UIKit

open class DPRefreshControl: UIRefreshControl, DPViewProtocol, DPRefreshControlProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupComponents()
    }
    
    public convenience init(didBeginRefreshing: (() -> Void)?) {
        self.init(frame: .zero)
        
        self.didBeginRefreshing = didBeginRefreshing
        self.setupComponents()
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
    open func setupComponents() {
        self.addTarget(self, action: #selector(self.handleValueChanged(_:)), for: .valueChanged)
    }
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
}

// MARK: - UIRefreshControl + DPRefreshControl
public extension UIRefreshControl {
    
    static func refreshControl(didBeginRefreshing: (() -> Void)?) -> DPRefreshControl {
        .init(didBeginRefreshing: didBeginRefreshing)
    }
    
}
