import Foundation
import UIKit

open class DPTabBarItem: UITabBarItem {
    
    // MARK: - Props
    open override var title: String? {
        didSet {
            self.didSetTitle?(self.title)
        }
    }
    
    open override var badgeValue: String? {
        didSet {
            self.didSetBadgeValue?(self.badgeValue)
        }
    }
    
    open var didSetTitle: ((String?) -> Void)?
    open var didSetBadgeValue: ((String?) -> Void)?
}
