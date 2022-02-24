import Foundation
import UIKit

public extension UIImage {
    
    // MARK: - Round methods
    
    /// Creates a rounded image.
    /// - Parameter radius: Rounding radius value.
    /// - Returns: Rounded image.
    ///
    
    func rounding(_ radius: CGFloat) -> UIImage? {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: self.size)
        UIGraphicsBeginImageContextWithOptions(self.size, false, 1)
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        self.draw(in: rect)
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
