import Foundation
import UIKit

public protocol DPViewControllerInput: AnyObject {}

open class DPViewController: UIViewController, DPViewControllerInput {
    
    // MARK: - Props
    open var _model: DPViewModelInput?
    open var _router: DPViewRouter?
    open var _errorHanlder: DPViewErrorHandler?
    
    open lazy var notificationObserver: DPNotificationObserver = .init()
    
    // MARK: - Lifecycle
    public init(
        model: DPViewModelInput,
        router: DPViewRouter = DPViewRouter(),
        errorHanlder: DPViewErrorHandler = .init()
    ) {
        super.init(nibName: nil, bundle: nil)
        
        self._model = model
        
        self._router = router
        self._router?.viewController = self
        
        self._errorHanlder = errorHanlder
        self._errorHanlder?.viewController = self
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
    open func setupComponets() {}
    
    open func updateComponets() {}
    
    open func showError(_ error: Error, completion: (() -> Void)? = nil) {
        self._errorHanlder?.showError(error, completions: completion)
    }
}
