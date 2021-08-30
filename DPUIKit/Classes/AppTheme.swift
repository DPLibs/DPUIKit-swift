import Foundation
import UIKit

public struct AppTheme {
    
    // MARK: - Static
    public static let currentStyleRawValueKey: String = "AppTheme.currentStyleRawValueKey"
    public static let useSystemStyleKey: String = "AppTheme.useSystemStyleKey"
    
    public static let didSetCurrentNotification: Notification.Name = .init("AppTheme.didSetCurrentNotification")
    
    public static var current: Self {
        get {
            let key = AppTheme.currentStyleRawValueKey
            let styleSystem = AppTheme.Style.generateSystem()
            
            if UserDefaults.standard.value(forKey: key) == nil {
                UserDefaults.standard.setValue(styleSystem.rawValue, forKey: key)
            }
            
            return .init(style: .init(rawValue: UserDefaults.standard.string(forKey: key) ?? styleSystem.rawValue))
        }
        set {
            UserDefaults.standard.setValue(newValue.style.rawValue, forKey: AppTheme.currentStyleRawValueKey)
            NotificationCenter.default.post(name: AppTheme.didSetCurrentNotification, object: newValue)
        }
    }
    
    public static var useSystemStyle: Bool {
        get {
            let key = AppTheme.useSystemStyleKey
            
            if UserDefaults.standard.value(forKey: key) == nil {
                UserDefaults.standard.setValue(true, forKey: key)
            }
            
            return UserDefaults.standard.bool(forKey: key)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: AppTheme.useSystemStyleKey)
            
            if newValue {
                AppTheme.current = .init(style: .generateSystem())
            }
        }
    }
    
    // MARK: - Props
    public let style: Style
    
}

// MARK: - Style
extension AppTheme {
    
    public struct Style: Equatable {
        
        // MARK: - Static
        public static let light: Self = .init(rawValue: "light")
        public static let dark: Self = .init(rawValue: "dark")
        
        // MARK: - Props
        public let rawValue: String
        
        // MARK: - Methods
        public static func generateSystem() -> Self {
            if #available(iOS 12.0, *) {
                switch UIScreen.main.traitCollection.userInterfaceStyle {
                case .dark:
                    return .dark
                case .light:
                    return .light
                case .unspecified:
                    return .light
                @unknown default:
                    return .light
                }
            } else {
                return .light
            }
        }
    }
    
}
