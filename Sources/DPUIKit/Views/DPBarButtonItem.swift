//
//  DPBarButtonItem.swift
//  Demo
//
//  Created by Дмитрий Поляков on 05.10.2023.
//

import Foundation
import UIKit

open class DPBarButtonItem: UIBarButtonItem {
    
    // MARK: - Init
    public convenience init(image: UIImage?, style: UIBarButtonItem.Style, onAction: (() -> Void)?) {
        self.init(image: image, style: style, target: nil, action: nil)
        self.onAction = onAction
        self.onActionDidSet()
    }

    public convenience init(image: UIImage?, landscapeImagePhone: UIImage?, style: UIBarButtonItem.Style, onAction: (() -> Void)?) {
        self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
        self.onAction = onAction
        self.onActionDidSet()
    }

    public convenience init(title: String?, style: UIBarButtonItem.Style, onAction: (() -> Void)?) {
        self.init(title: title, style: style, target: nil, action: nil)
        self.onAction = onAction
        self.onActionDidSet()
    }

    public convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem, onAction: (() -> Void)?) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        self.onAction = onAction
        self.onActionDidSet()
    }
    
    // MARK: - Props
    open var onAction: (() -> Void)? {
        didSet { self.onActionDidSet() }
    }
    
    // MARK: - Methods
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func onActionDidSet() {
        if self.onAction == nil {
            self.target = nil
            self.action = nil
        } else {
            self.target = self
            self.action = #selector(self.handleAction)
        }
    }
    
    @objc
    open func handleAction() {
        self.onAction?()
    }
    
}
