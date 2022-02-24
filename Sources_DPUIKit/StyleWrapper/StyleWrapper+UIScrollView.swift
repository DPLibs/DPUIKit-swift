import Foundation
import UIKit

public extension StyleWrapper where Element: UIScrollView {
    
    static func showsHorizontalScrollIndicator(_ value: Bool) -> StyleWrapper {
        return .wrap { scrollView in
            scrollView.showsHorizontalScrollIndicator = value
        }
    }
    
    static func showsVerticalScrollIndicator(_ value: Bool) -> StyleWrapper {
        return .wrap { scrollView in
            scrollView.showsVerticalScrollIndicator = value
        }
    }
    
    static func contentInset(_ value: UIEdgeInsets) -> StyleWrapper {
        return .wrap { scrollView in
            scrollView.contentInset = value
        }
    }
    
}
