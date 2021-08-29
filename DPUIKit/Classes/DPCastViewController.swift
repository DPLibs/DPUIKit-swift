import Foundation
import UIKit

open class DPCastViewController<Model: DPViewModelInput, Router: DPViewRouter, ErrorHandler: DPViewErrorHandler>: DPViewController {
    
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
            self._errorHanlder as? ErrorHandler
        }
        set {
            self._errorHanlder = newValue
        }
    }
    
    // MARK: - Init
    public convenience init(cast model: Model, router: Router, errorHanlder: ErrorHandler) {
        self.init(model: model, router: router, errorHanlder: errorHanlder)
    }
    
}
