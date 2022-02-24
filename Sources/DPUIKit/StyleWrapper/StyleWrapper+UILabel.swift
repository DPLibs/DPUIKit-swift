import Foundation
import UIKit

public extension StyleWrapper where Element: UILabel {
    
    static func numberOfLines(_ value: Int) -> StyleWrapper {
        return .wrap { label in
            label.numberOfLines = value
        }
    }
    
    static func textAlignment(_ value: NSTextAlignment) -> StyleWrapper {
        return .wrap { label in
            label.textAlignment = value
        }
    }
    
    static func text(_ value: String?) -> StyleWrapper {
        return .wrap { label in
            label.text = value
        }
    }
    
    static func textColor(_ color: UIColor?) -> StyleWrapper {
        return .wrap { label in
            label.textColor = color
        }
    }
    
    static func lineBreakMode(_ value: NSLineBreakMode) -> StyleWrapper {
        return .wrap { label in
            label.lineBreakMode = value
        }
    }
    
}
