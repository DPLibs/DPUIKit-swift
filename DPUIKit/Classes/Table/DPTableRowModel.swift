import Foundation
import UIKit

open class DPTableRowModel {
    
    // MARK: - Props
    open var cellIdentifier: String? {
        nil
    }

    open var cellHeight: CGFloat {
        UITableViewAutomaticDimension
    }
    
    open var cellEstimatedHeight: CGFloat {
        50
    }
    
    public var didTap: (() -> Void)?

    // MARK: - Init
    public init(didTap: (() -> Void)? = nil) {
        self.didTap = didTap
    }
    
    // MARK: - Methods
    open func createLeadingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? {
        .empty
    }
    
    open func createTrailingSwipeActionsConfiguration(for cell: UITableViewCell) -> UISwipeActionsConfiguration? {
        .empty
    }
    
    open func willBeginEditing(for cell: UITableViewCell) { }
    
    open func didEndEditing(for cell: UITableViewCell) { }
    
}

