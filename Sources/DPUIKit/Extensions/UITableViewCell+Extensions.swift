import Foundation
import UIKit

public extension UITableViewCell {
    
    /// Returns the table as superview or nil.
    ///
    var tableView: UITableView? {
        self.superview as? UITableView
    }
    
    /// Updates the cell initialize the `performBatchUpdates()` of the parent table.
    ///
    func reloadCellView() {
        self.tableView?.performBatchUpdates(nil, completion: nil)
    }
    
}
