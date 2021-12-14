import Foundation
import UIKit

public extension UIButton {
    
    // MARK: - Style methods
    
    /// Sets the background color of the button to the specified state.
    /// - Parameter color - Sets background color.
    /// - Parameter state - State for the color.
    ///
    func setBackgroundColor(color: UIColor, forState state: UIControl.State) {
        self.clipsToBounds = true
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: state)
    }
    
}
