//
//  DPViewController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPViewController: UIViewController, DPViewProtocol, DPViewModelOutput {
    
    // MARK: - Init
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    // MARK: - Props
    open var _model: DPViewModel? {
        didSet {
            self.modelDidSet()
        }
    }
    
    open var _router: DPViewRouter? = DPViewRouter() {
        didSet {
            self.routerDidSet()
        }
    }
    
    open var _errorHandler: DPViewErrorHandler? = DPViewErrorHandler() {
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
        self._model?._output = self
    }
    
    open func routerDidSet() {
        self._router?.viewController = self
    }
    
    open func errorHandlerDidSet() {
        self._errorHandler?.viewController = self
    }
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
    // MARK: - DPViewModelOutput
    open func modelDidError(_ model: DPViewModel?, error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?._errorHandler?.handleError(error)
        }
    }
    
    open func modelBeginLoading(_ model: DPViewModel?) {}
    open func modelFinishLoading(_ model: DPViewModel?, withError error: Error?) {}
    open func modelUpdated(_ model: DPViewModel?) {}
    open func modelReloaded(_ model: DPViewModel?) {}
    
}
