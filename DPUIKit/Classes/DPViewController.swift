import Foundation
import UIKit

public protocol DPViewControllerInput: AnyObject {}

open class DPViewController: UIViewController, DPViewProtocol, DPViewControllerInput {
    
    // MARK: - Props
    open var _model: DPViewModelInput?
    open var _router: DPViewRouter?
    open var _errorHanlder: DPViewErrorHandler?
    
    open lazy var notificationObserver: DPNotificationObserver = .init()
    
    // MARK: - Lifecycle
    public convenience init(_model: DPViewModel?, _router: DPViewRouter?, _errorHanlder: DPViewErrorHandler?) {
        self.init(nibName: nil, bundle: nil)
        
        self._model = _model
        
        self._router = _router
        self._router?.viewController = self
        
        self._errorHanlder = _errorHanlder
        self._errorHanlder?.viewController = self
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
        self._errorHanlder?.showError(error, completions: completion)
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
