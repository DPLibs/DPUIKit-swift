//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright © ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class ___VARIABLE_moduleName___ViewController: DPViewController {
    
    // MARK: - Init
    override init() {
        super.init()
        
        self.model = .init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: ___VARIABLE_moduleName___ViewModel? {
        get { self._model as? ___VARIABLE_moduleName___ViewModel }
        set { self._model = newValue }
    }
    
    // MARK: - Methods
    
}
