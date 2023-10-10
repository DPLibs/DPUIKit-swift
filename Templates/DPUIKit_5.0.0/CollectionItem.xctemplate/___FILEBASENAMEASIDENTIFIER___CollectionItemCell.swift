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

final class ___VARIABLE_productName___CollectionItemCell: ___VARIABLE_prefixSuperclass___CollectionItemCell {
    
    // MARK: - Props
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    // MARK: - Methods

}

// MARK: - Types
extension ___VARIABLE_productName___CollectionItemCell {
    
    typealias Adapter = DPCollectionItemAdapter<___VARIABLE_productName___CollectionItemCell, Model>
    
    struct Model {}
    
}
