//
//  DPWindowCoordinator.swift
//  
//
//  Created by Дмитрий Поляков on 03.06.2022.
//

import Foundation
import UIKit

open class DPWindowCoordinator: DPCoordinatorProtocol {
    
    // MARK: - Init
    
    /// In the `init` you can pass `UIWindow` for control
    public init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Props
    
    /// `UIWindow` for control
    open weak var window: UIWindow?
    
    /// Thrown property `UIWindow`. When setting the value of this property, the installed `UIViewController` is displayed
    open var rootViewController: UIViewController? {
        get { self.window?.rootViewController }
        set {
            self.window?.rootViewController = newValue
            self.window?.makeKeyAndVisible()
        }
    }
    
    // MARK: - DPCoordinatorProtocol
    open var didStart: ((DPCoordinatorProtocol?) -> Void)?
    open var didFinish: ((DPCoordinatorProtocol?) -> Void)?
    
    open func start() {
        self.didStart?(self)
    }
    
    open func finish() {
        self.didFinish?(self)
    }
    
    // MARK: - Methods
    
    /// Method for installing `viewController` in `rootViewController`
    open func show(_ viewController: UIViewController, animated: Bool = true) {
        self.rootViewController = viewController
    }
    
}
