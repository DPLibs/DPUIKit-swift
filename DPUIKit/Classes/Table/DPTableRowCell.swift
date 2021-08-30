import Foundation
import UIKit

open class DPTableRowCell<RowModel: DPTableRowModel>: DPTableViewCell {
    
    // MARK: - Props
    open var model: RowModel? {
        get {
            self._model as? RowModel
        }
        set {
            self._model = newValue
        }
    }
    
}
