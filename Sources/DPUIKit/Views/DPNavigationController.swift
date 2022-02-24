//
//  DPNavigationController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPNavigationController: UINavigationController, DPViewProtocol, UIGestureRecognizerDelegate {
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
    }
    
    // MARK: - DPViewProtocol
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
