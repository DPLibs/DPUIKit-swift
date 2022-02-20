import Foundation
import UIKit

public extension UITableViewCell {
    
    /// Returns the table as superview or nil.
    ///
    var table: UITableView? {
        self.superview as? UITableView
    }
    
    /// Updates the cell initialize the `performBatchUpdates()` of the parent table.
    ///
    func reloadCellView() {
        self.table?.performBatchUpdates(nil, completion: nil)
    }
    
}
