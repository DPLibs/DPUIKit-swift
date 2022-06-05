import Foundation
import UIKit

public extension StyleWrapper where Element: UIImageView {
    
    static func image(_ value: UIImage?) -> StyleWrapper {
        return .wrap { imageView in
            imageView.image = value
        }
    }
    
    static func contentMode(_ value: UIView.ContentMode) -> StyleWrapper {
        return .wrap { imageView in
            imageView.contentMode = value
            imageView.layer.masksToBounds = true
        }
    }
    
}
