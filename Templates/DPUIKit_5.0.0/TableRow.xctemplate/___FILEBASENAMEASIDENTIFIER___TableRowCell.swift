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

final class ___VARIABLE_productName___TableRowCell: ___VARIABLE_prefixSuperclass___TableRowCell {
    
    // MARK: - Props
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    // MARK: - Methods

}

// MARK: - Model
extension ___VARIABLE_productName___TableRowCell {
    
    typealias Adapter = DPTableRowAdapter<___VARIABLE_productName___TableRowCell, Model>
    
    struct Model: DPRepresentableModel {}
    
}
