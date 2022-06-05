import Foundation
import UIKit

public extension StyleWrapper where Element: UITableView {
    
    static var tableDefault: StyleWrapper {
        return .wrap { table in
            table.rowHeight = UITableView.automaticDimension
            table.backgroundColor = .clear
            table.separatorStyle = .none
            table.delaysContentTouches = false
            table.allowsSelectionDuringEditing = false
            table.keyboardDismissMode = .onDrag
            table.sectionHeaderHeight = UITableView.automaticDimension
        }
    }
    
    static func contentInset(_ value: UIEdgeInsets) -> StyleWrapper {
        return .wrap { table in
            table.contentInset = value
        }
    }
    
    static func keyboardDismissMode(_ value: UIScrollView.KeyboardDismissMode) -> StyleWrapper {
        return .wrap { table in
            table.keyboardDismissMode = value
        }
    }
    
    static func estimatedRowHeight(_ value: CGFloat) -> StyleWrapper {
        return .wrap { table in
            table.estimatedRowHeight = value
        }
    }
    
    static func isScrollEnabled(_ value: Bool) -> StyleWrapper {
        return .wrap { table in
            table.isScrollEnabled = value
        }
    }
    
}
