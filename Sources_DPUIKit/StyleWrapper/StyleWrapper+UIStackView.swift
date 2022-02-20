import Foundation
import UIKit

public extension StyleWrapper where Element: UIStackView {
    
    static func spacing(_ value: CGFloat) -> StyleWrapper {
        return .wrap { stackView in
            stackView.spacing = value
        }
    }
    
    static func distribution(_ value: UIStackView.Distribution) -> StyleWrapper {
        return .wrap { stackView in
            stackView.distribution = value
        }
    }
    
    static func axis(_ value: NSLayoutConstraint.Axis) -> StyleWrapper {
        return .wrap { stackView in
            stackView.axis = value
        }
    }
    
    static func alignment(_ value: UIStackView.Alignment) -> StyleWrapper {
        return .wrap { stackView in
            stackView.alignment = value
        }
    }
    
    static func insets(_ value: UIEdgeInsets) -> StyleWrapper {
        return .wrap { stackView in
            stackView.layoutMargins = value
        }
    }
    
    static func directionalLayoutMargins(_ value: NSDirectionalEdgeInsets) -> StyleWrapper {
        return .wrap { stackView in
            stackView.directionalLayoutMargins = value
            stackView.isLayoutMarginsRelativeArrangement = true
        }
    }
    
}
