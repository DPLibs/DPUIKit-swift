import Foundation
import UIKit

public extension StyleWrapper where Element: UIButton {
    
    static func setTitle(_ value: String?, state: UIControl.State = .normal) -> StyleWrapper {
        return .wrap { button in
            button.setTitle(value, for: state)
        }
    }
    
    static func setImage(_ value: UIImage?, state: UIControl.State = .normal) -> StyleWrapper {
        return .wrap { button in
            button.setImage(value, for: state)
        }
    }
    
    static func setBackgroundImage(_ value: UIImage?, state: UIControl.State = .normal) -> StyleWrapper {
        return .wrap { button in
            button.setBackgroundImage(value, for: state)
        }
    }
    
    static func contentEdgeInsets(_ value: UIEdgeInsets) -> StyleWrapper {
        return .wrap { button in
            button.contentEdgeInsets = value
        }
    }
    
    static func tintColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { button in
            button.tintColor = value
        }
    }
    
    static func setTitleColor(_ value: UIColor, state: UIControl.State = .normal) -> StyleWrapper {
        return .wrap { button in
            button.setTitleColor(value, for: state)
        }
    }
    
    static func font(_ value: UIFont) -> StyleWrapper {
        return .wrap { button in
            button.titleLabel?.font = value
        }
    }
    
    static func semanticContentAttribute(_ value: UISemanticContentAttribute) -> StyleWrapper {
        return .wrap { button in
            button.semanticContentAttribute = value
        }
    }
    
    static func backgroundColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { button in
            button.backgroundColor = value
        }
    }
    
    static func adjustsFontSizeToFitWidth(_ value: Bool) -> StyleWrapper {
        return .wrap { button in
            button.titleLabel?.adjustsFontSizeToFitWidth = value
        }
    }
    
    static func minimumScaleFactor(_ value: CGFloat) -> StyleWrapper {
        return .wrap { button in
            button.titleLabel?.minimumScaleFactor = value
        }
    }
    
    static func numberOfLines(_ value: Int) -> StyleWrapper {
        return .wrap { button in
            button.titleLabel?.numberOfLines = value
        }
    }
    
}
