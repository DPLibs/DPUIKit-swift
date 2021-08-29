import Foundation
import UIKit

open class DPViewRouter {
    
    // MARK: - Props
    open weak var viewController: UIViewController?
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Methods
    open func setupRootController(_ viewController: UIViewController) {
        let window = self.viewController?.view.window
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        self.viewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    open func push(viewController: UIViewController, animated: Bool) {
        self.viewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    open func popViewController(animated: Bool) -> UIViewController? {
        self.viewController?.navigationController?.popViewController(animated: animated)
    }

    @discardableResult
    open func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        self.viewController?.navigationController?.popToViewController(viewController, animated: animated)
    }

    @discardableResult
    open func popToRootViewController(animated: Bool) -> [UIViewController]? {
        self.viewController?.navigationController?.popToRootViewController(animated: animated)
    }
    
}
