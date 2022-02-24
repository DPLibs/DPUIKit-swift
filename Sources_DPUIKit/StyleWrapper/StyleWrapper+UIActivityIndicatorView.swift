import Foundation
import UIKit

public extension StyleWrapper where Element: UIActivityIndicatorView {
    
    static var activityDefault: StyleWrapper {
        return .wrap { activity in
            activity.hidesWhenStopped = true
            activity.style = .gray
        }
    }
    
}
