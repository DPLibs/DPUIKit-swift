import Foundation
import UIKit

open class DPTableSectionHeaderModel {

    // MARK: - Props
    open var viewIdentifier: String? {
        nil
    }

    open var viewHeight: CGFloat {
        UITableViewAutomaticDimension
    }

    open var viewEstimatedHeight: CGFloat {
        32.0
    }

    // MARK: - Init
    public init() { }
    
}
