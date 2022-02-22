//
//  DPFlowViewController.swift
//  
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import UIKit

open class DPFlowViewController: DPViewController {
    
    // MARK: - Props
    open var rootViewController: UIViewController? {
        didSet {
            self.rootViewControllerDidSet(oldValue: oldValue)
        }
    }
    
    open var didBeginFlow: Closure?
    open var didFinishFlow: Closure?
    
    // MARK: - Methods
    open func rootViewControllerDidSet(oldValue: UIViewController? = nil) {
        oldValue?.view.removeFromSuperview()
        oldValue?.removeAsChildFromParent()
        
        guard let rootViewController = self.rootViewController else { return }
        rootViewController.addAsChildToParent(self)
        rootViewController.view.addToSuperview(self.view, withConstraints: [ .edgesToSuperview() ])
    }
    
    open func beginFlow() {
        self.didBeginFlow?()
    }
    
    open func finishFlow() {
        self.didFinishFlow?()
    }
    
}

// MARK: - UIViewController + DPFlowViewController
public extension UIViewController {
    
    func findFlow<T: DPFlowViewController>(_ type: T.Type) -> T? {
        guard let parent = self.parent else { return nil }
        
        if let flow = parent as? T {
            return flow
        } else {
            return parent.findFlow(T.self)
        }
    }
    
}
