//
//  DPViewController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPViewController: UIViewController, DPViewProtocol {
    
    // MARK: - Props
    open var _model: DPViewModel?
    open var _router: DPViewRouter?
    open var _errorHandler: DPViewErrorHandler?
    
    open lazy var notificationObserver: DPNotificationObserver = .init()
    
    // MARK: - Lifecycle
    public convenience init(
        _model: DPViewModel?,
        _router: DPViewRouter?,
        _errorHandler: DPViewErrorHandler?
    ) {
        self.init(nibName: nil, bundle: nil)
        
        self._model = _model
        
        self._router = _router
        self._router?.viewController = self
        
        self._errorHandler = _errorHandler
        self._errorHandler?.viewController = self
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
        self.updateComponents()
    }
    
    // MARK: - Methods
    open func reloadData() {}
    
    open func loadData() {}
    
    open func showError(_ error: Error, completion: (() -> Void)? = nil) {
        self._errorHandler?.showError(error, completions: completion)
    }
    
    // MARK: - DPViewProtocol
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}
