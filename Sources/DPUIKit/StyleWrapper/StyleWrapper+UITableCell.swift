import Foundation
import UIKit

public extension StyleWrapper where Element: UITableViewCell {
    
    static var tableCellDefault: StyleWrapper {
        return .wrap { cell in
            cell.backgroundColor = .clear
            cell.contentView.backgroundColor = .clear
            cell.selectionStyle = .none
        }
    }
    
    static var hideSeparator: StyleWrapper {
        return .wrap { cell in
            cell.separatorInset = UIEdgeInsets(top: .zero, left: cell.bounds.width, bottom: .zero, right: .zero)
        }
    }
    
}
