import Foundation
import UIKit

public extension StyleWrapper where Element: UIView {
    
    // MARK: - Rect
    static func frame(_ value: CGRect) -> StyleWrapper {
        return .wrap { view in
            view.frame = value
        }
    }
    
    static func bounds(_ value: CGRect) -> StyleWrapper {
        return .wrap { view in
            view.bounds = value
        }
    }
    
    // MARK: - Background color
    static func backgroundColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { view in
            view.backgroundColor = value
        }
    }
    
    static func backgroundColorAlpha(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.backgroundColor = view.backgroundColor?.withAlphaComponent(value)
        }
    }
    
    static var backgroundColorClear: StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .clear
        }
    }
    
    static var backgroundColorWhite: StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .white
        }
    }
    
    static var backgroundColorBlack: StyleWrapper {
        return .wrap { view in
            view.backgroundColor = .black
        }
    }
    
    // MARK: - Border
    static func borderWidth(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.layer.borderWidth = value
        }
    }
    
    static func borderColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { view in
            view.layer.borderColor = value.cgColor
        }
    }
    
    // MARK: - Radius
    static func cornerRadius(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = value
        }
    }
    
    static func cornerRadiusTop(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = value
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    static func cornerRadiusBottom(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = value
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    static func cornerRadiusLeft(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = value
            view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }
    }
    
    static func cornerRadiusRight(_ value: CGFloat) -> StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = value
            view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        }
    }
    
    static var cornerRadiusCircle: StyleWrapper {
        return .wrap { view in
            view.layer.cornerRadius = view.frame.height / 2
        }
    }
    
    static func maskedCorners(_ value: CACornerMask) -> StyleWrapper {
        return .wrap { view in
            view.layer.maskedCorners = value
        }
    }
    
    // MARK: - Shadow
    static func shadowLayer(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) -> StyleWrapper {
        return .wrap { view in
            view.layer.masksToBounds = false
            view.layer.shadowColor = color.cgColor
            view.layer.shadowPath = UIBezierPath(roundedRect: view.bounds, cornerRadius: view.layer.cornerRadius).cgPath
            view.layer.shadowOffset = offset
            view.layer.shadowOpacity = opacity
            view.layer.shadowRadius = radius
        }
    }
    
    static var shadowLayerClear: StyleWrapper {
        return .wrap { view in
            view.layer.masksToBounds = false
            view.layer.shadowColor = UIColor.clear.cgColor
            view.layer.shadowPath = UIBezierPath(roundedRect: .zero, cornerRadius: .zero).cgPath
            view.layer.shadowOffset = .zero
            view.layer.shadowOpacity = .zero
            view.layer.shadowRadius = .zero
        }
    }
    
    static func shadowView(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) -> StyleWrapper {
        return .wrap { view in
            view.appendShadowView(
                viewBounds: view.bounds,
                viewRadius: view.layer.cornerRadius,
                shadowColor: color,
                shadowOffset: offset,
                shadowRadius: radius,
                shadowOpacity: opacity
            )
        }
    }
    
    static var shadowViewRemove: StyleWrapper {
        return .wrap { view in
            view.removeShadowView()
        }
    }
    
    // MARK: - Other
    static func tintColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { view in
            view.tintColor = value
        }
    }
    
    static func clipsToBounds(_ value: Bool) -> StyleWrapper {
        return .wrap { view in
            view.clipsToBounds = value
        }
    }
    
}
