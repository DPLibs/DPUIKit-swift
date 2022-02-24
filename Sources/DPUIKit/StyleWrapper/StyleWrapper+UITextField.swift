import Foundation
import UIKit

public extension StyleWrapper where Element: UITextField {
    
    static func textAlignment(_ value: NSTextAlignment) -> StyleWrapper {
        return .wrap { textField in
            textField.textAlignment = value
        }
    }
    
    static func keyboardType(_ value: UIKeyboardType) -> StyleWrapper {
        return .wrap { textField in
            textField.keyboardType = value
        }
    }
    
    static func autocapitalizationType(_ value: UITextAutocapitalizationType) -> StyleWrapper {
        return .wrap { textField in
            textField.autocapitalizationType = value
        }
    }
    
    static func textColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { textField in
            textField.textColor = value
        }
    }
    
    static func placeholder(_ text: String?) -> StyleWrapper {
        return .wrap { textField in
            textField.placeholder = text
        }
    }
    
}
