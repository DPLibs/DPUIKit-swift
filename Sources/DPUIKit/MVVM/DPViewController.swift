//
//  DPViewController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

/// Needed to display views and transition to other screens.
///
/// Part of <doc:MVVM>.
/// Stores an instance of ``DPViewModel``. And implements the ``DPViewModelOutput`` protocol to process signals from ``DPViewModel``.
/// Stores an instance of ``DPViewErrorHandler`` for handling and displaying errors.
open class DPViewController: UIViewController, DPViewProtocol, DPViewModelOutput, DPCoordinatableViewController {
    
    // MARK: - Init
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        self.commonInit()
    }
    
    // MARK: - Props
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        self.statusBarStyle
    }
    
    open var statusBarStyle: UIStatusBarStyle = .default {
        didSet { self.statusBarStyleDidSet() }
    }
    
    open var _model: DPViewModel? {
        didSet { self.modelDidSet() }
    }
    
    open var _errorHandler: DPViewErrorHandler? = DPViewErrorHandler() {
        didSet { self.errorHandlerDidSet() }
    }
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.willEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.didEnterBackground),
            name: UIApplication.didEnterBackgroundNotification,
            object: nil
        )
        
        self.setupComponents()
        self.updateComponents()
    }
    
    @objc
    open func willEnterForeground() {}
    
    @objc
    open func didEnterBackground() {}
     
    open func statusBarStyleDidSet() {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - DPViewProtocol
    open func commonInit () {
        self.modelDidSet()
        self.errorHandlerDidSet()
    }
    
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func modelDidSet() {
        self._model?._output = self
    }
    
    open func errorHandlerDidSet() {
        self._errorHandler?.viewController = self
    }
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    // MARK: - DPViewModelOutput
    open func modelDidError(_ model: DPViewModel?, error: Error) {
        self._errorHandler?.handleError(error)
    }
    
    open func modelBeginReloading(_ model: DPViewModel?) {}
    
    open func modelBeginLoading(_ model: DPViewModel?) {}
    
    open func modelFinishLoading(_ model: DPViewModel?, withError error: Error?) {
        if let error {
            self._errorHandler?.handleError(error)
        }
    }
    
    open func modelUpdated(_ model: DPViewModel?) {
        self.updateComponents()
    }
    
    open func modelReloaded(_ model: DPViewModel?) {}
    
    // MARK: - DPCoordinatableViewController
    open var coordinator: DPCoordinatorProtocol?
    
}
