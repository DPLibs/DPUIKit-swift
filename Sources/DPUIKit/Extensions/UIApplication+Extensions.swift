import Foundation
import UIKit

public extension UIApplication {
    
    // MARK: - Controllers methods
    
    /// Returns the top view controller in the application.
    /// - Returns: Top view controller or nil .
    ///
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return self.topViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return self.topViewController(base: selected)
            }
        }
        
        if let presented = base?.presentedViewController {
            return self.topViewController(base: presented)
        }
        
        return base
    }
    
    // MARK: - Screen methods
    
    /// Creates a screenshot of the keyWindow layer.
    /// - Returns: Created image.
    ///
    func createScreenshot() -> UIImage? {
        guard let layer = self.keyWindow?.layer else { return nil }
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, true, .zero)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return image
    }
    
    // MARK: - Open methods
    
    /// Opens the application settings page on the device.
    /// - Returns: Retrun `true` if settings opening.
    ///
    func openApplicationSettings() -> Bool {
        guard let url = URL(string: UIApplication.openSettingsURLString), self.canOpenURL(url) else { return false }
        self.open(url, options: [:], completionHandler: nil)
        return true
    }
    
}
