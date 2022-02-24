import Foundation
import UIKit

public extension StyleWrapper where Element: UINavigationBar {
    
    static var navBarLight: StyleWrapper {
        return .wrap { navigationBar in
            navigationBar.backgroundColor = .clear
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.barStyle = .default
            navigationBar.tintColor = .black
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }
    
    static func navBarLightWithImage(_ image: UIImage?) -> StyleWrapper {
        return .wrap { navigationBar in
            navigationBar.backgroundColor = .clear
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(image, for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.barStyle = .default
            navigationBar.tintColor = .black
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        }
    }
    
    static var navBarDark: StyleWrapper {
        return .wrap { navigationBar in
            navigationBar.backgroundColor = .clear
            navigationBar.isTranslucent = true
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
            navigationBar.barStyle = .black
            navigationBar.tintColor = .white
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }
    }
    
}
