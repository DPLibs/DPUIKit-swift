import Foundation
import UIKit

public extension StyleWrapper where Element: UISwitch {
    
    static func switchOnTintColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { swt in
            swt.onTintColor = value
        }
    }
    
    static func switchTintColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { swt in
            swt.tintColor = value
        }
    }
    
}
