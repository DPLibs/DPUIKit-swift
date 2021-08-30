import Foundation
import UIKit

public protocol DPViewControllerInput: AnyObject {}

open class DPViewController<Model: DPViewModelInput, Router: DPViewRouter, ErrorHandler: DPViewErrorHandler>: UIViewController, DPViewProtocol, DPViewControllerInput {
    
    // MARK: - Props
    open var model: Model?
    open var router: Router?
    open var errorHanlder: ErrorHandler?
    
    open lazy var notificationObserver: DPNotificationObserver = .init()
    
    // MARK: - Lifecycle
    public init(
        model: Model,
        router: Router,
        errorHanlder: ErrorHandler
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self.model = model
        
        self.router = router
        self.router?.viewController = self
        
        self.errorHanlder = errorHanlder
        self.errorHanlder?.viewController = self
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
        self.updateComponets()
    }
    
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupComponets()
    }
    
    // MARK: - Methods
    open func reloadData() {}
    
    open func loadData() {}
    
    open func showError(_ error: Error, completion: (() -> Void)? = nil) {
        self.errorHanlder?.showError(error, completions: completion)
    }
    
    // MARK: - DPViewProtocol
    open func setupComponets() {}
    
    open func updateComponets() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}
