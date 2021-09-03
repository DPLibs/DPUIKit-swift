//
//  DPCastViewController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPCastViewController<Model: DPViewModelInput, Router: DPViewRouter, ErrorHandler: DPViewErrorHandler>: DPViewController {
    
    // MARK: - Props
    open var model: Model?
    open var router: Router?
    open var errorHanlder: ErrorHandler?
    
    // MARK: - Init
    public convenience init(model: Model?, router: Router?, errorHanlder: ErrorHandler?) {
        self.init(_model: model as? DPViewModel, _router: router, _errorHanlder: errorHanlder)
    }
    
}
 
