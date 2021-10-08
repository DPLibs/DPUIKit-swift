//
//  DPCastViewController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPCastViewController<Model: DPViewModel, Router: DPViewRouter, ErrorHandler: DPViewErrorHandler>: DPViewController {
    
    // MARK: - Props
    open var model: Model? {
        get {
            self._model as? Model
        }
        set {
            self._model = newValue
        }
    }
    
    open var router: Router? {
        get {
            self._router as? Router
        }
        set {
            self._router = newValue
        }
    }
    
    open var errorHandler: ErrorHandler? {
        get {
            self._errorHandler as? ErrorHandler
        }
        set {
            self._errorHandler = newValue
        }
    }
    
    // MARK: - Init
    public convenience init(
        model: Model,
        router: Router,
        errorHandler: ErrorHandler
    ) {
        self.init(
            _model: model,
            _router: router,
            _errorHandler: errorHandler
        )
    }
    
}
 
