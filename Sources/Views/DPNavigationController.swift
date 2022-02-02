//
//  DPNavigationController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPNavigationController: UINavigationController, DPViewProtocol, UIGestureRecognizerDelegate {
    
    // MARK: - Init
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.commonInit()
    }
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
    }
    
    // MARK: - DPViewProtocol
    open func commonInit() {}
    
    open func setupComponents() {
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
    // MARK: - UIGestureRecognizerDelegate
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
