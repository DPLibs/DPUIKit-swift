//
//  DPViewController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPViewController: UIViewController, DPViewProtocol {
    
    // MARK: - Init
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    public convenience init(
        _model: DPViewModel,
        _router: DPViewRouter,
        _errorHandler: DPViewErrorHandler
    ) {
        self.init(nibName: nil, bundle: nil)
        
        self._model = _model
        self._router = _router
        self._errorHandler = _errorHandler
        
        self.commonInit()
    }
    
    // MARK: - Props
    open var _model: DPViewModel = DPViewModel() {
        didSet {
            self.modelDidSet()
        }
    }
    
    open var _router: DPViewRouter = DPViewRouter() {
        didSet {
            self.routerDidSet()
        }
    }
    
    open var _errorHandler: DPViewErrorHandler = DPViewErrorHandler() {
        didSet {
            self.errorHandlerDidSet()
        }
    }
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
        self.updateComponents()
    }
    
    // MARK: - DPViewProtocol
    open func commonInit () {
        self.modelDidSet()
        self.routerDidSet()
        self.errorHandlerDidSet()
    }
    
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func modelDidSet() {
        self._model.didError = { [weak self] error in
            DispatchQueue.main.async { [weak self] in
                self?._errorHandler.handleError(error)
            }
        }
    }
    
    open func routerDidSet() {
        self._router.viewController = self
    }
    
    open func errorHandlerDidSet() {
        self._errorHandler.viewController = self
    }
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}
