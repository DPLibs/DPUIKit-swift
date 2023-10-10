import Foundation
import UIKit

public extension StyleWrapper where Element: UITableView {
    
    static var tableDefault: StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .clear
            view.separatorStyle = .none
            view.keyboardDismissMode = .onDrag
        }
    }
    
    static func contentInset(_ value: UIEdgeInsets) -> StyleWrapper {
        return .wrap { view in
            view.contentInset = value
        }
    }
    
    static func keyboardDismissMode(_ value: UIScrollView.KeyboardDismissMode) -> StyleWrapper {
        return .wrap { view in
            view.keyboardDismissMode = value
        }
    }
    
    static func estimatedRowHeight(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.estimatedRowHeight = value
        }
    }
    
    static func isScrollEnabled(_ value: Bool) -> StyleWrapper {
        return .wrap { view in
            view.isScrollEnabled = value
        }
    }
    
}
