//
//  DPCastView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPCastView<Model>: DPView {
    
    open var model: Model? {
        get {
            self._model as? Model
        }
        set {
            self._model = newValue
        }
    }
    
}
