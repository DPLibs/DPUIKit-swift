import Foundation
import UIKit

open class DPTableSectionHeaderView<SectionHeaderModel: DPTableSectionHeaderModel>: DPTableViewHeaderFooterView {
    
    // MARK: - Props
    open var model: SectionHeaderModel? {
        get {
            self._model as? SectionHeaderModel
        }
        set {
            self._model = newValue
        }
    }
    
}
