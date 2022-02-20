import Foundation
import UIKit

public extension StyleWrapper where Element: UITabBar {
    
    static var tabBarDefault: StyleWrapper {
        return .wrap { tabBar in
            tabBar.isTranslucent = false
            tabBar.barTintColor = .white
            tabBar.unselectedItemTintColor = .white
            tabBar.tintColor = .white
            tabBar.backgroundImage = UIImage()
            tabBar.shadowImage = UIImage()
        }
    }

}
