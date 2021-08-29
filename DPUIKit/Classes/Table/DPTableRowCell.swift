import Foundation
import UIKit

open class DPTableRowCell<RowModel: DPTableRowModel>: DPTableViewCell {
    
    // MARK: - Props
    open var viewModel: RowModel? {
        get {
            self.model as? RowModel
        }
        set {
            self.model = newValue
        }
    }
    
}
