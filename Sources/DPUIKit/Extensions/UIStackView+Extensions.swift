import Foundation
import UIKit

public extension UIStackView {
    
    // MARK: - Subviews methods
    
    /// Add a views to the end of the arrangedSubviews list.
    /// - Parameter views: List of subviews for add.
    ///
    @discardableResult
    func addArrangedSubviews(_ views: [UIView]) -> UIStackView {
        views.forEach({ self.addArrangedSubview($0) })
        
        return self
    }
    
    @discardableResult
    func removeAllArrangedSubviews() -> UIStackView  {
        self.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        
        return self
    }
    
}
