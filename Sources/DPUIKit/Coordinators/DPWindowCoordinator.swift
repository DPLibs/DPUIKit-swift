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
    public init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: - Props
    open weak var window: UIWindow?
    
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
    open func show(_ viewController: UIViewController, animated: Bool = true) {
        self.rootViewController = viewController
    }
    
}
