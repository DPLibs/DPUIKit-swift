import Foundation
import UIKit

open class DPTableSectionHeaderView<SectionHeaderModel: DPTableSectionHeaderModel>: DPTableViewHeaderFooterView {
    
    // MARK: - Props
    open var viewModel: SectionHeaderModel? {
        get {
            self.model as? SectionHeaderModel
        }
        set {
            self.model = newValue
        }
    }
    
}
