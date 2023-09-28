//
//  DPNavigationCoordinator.swift
//  
//
//  Created by Дмитрий Поляков on 03.06.2022.
//

import Foundation
import UIKit

/// Manages within the `UINavigationController`.
open class DPNavigationCoordinator: DPCoordinatorProtocol {
    
    // MARK: - Init
    
    /// In the `init` you can pass `UINavigationController` for control
    public init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    // MARK: - Props
    
    /// `UINavigationController` for control
    open weak var navigationController: UINavigationController?
    
    /// Top controller in `navigationController` stack
    open var topViewController: UIViewController? {
        self.navigationController?.topViewController
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
        self.navigationController?.setViewControllers([viewController], animated: animated)
    }
    
    open func push(_ viewController: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    open func pop(animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    open func popToRoot(animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool = true, completion: (() -> Void)? = nil) {
        self.navigationController?.topViewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    open func set(_ viewControllers: [UIViewController], animated: Bool) {
        self.navigationController?.setViewControllers(viewControllers, animated: animated)
    }
    
}
