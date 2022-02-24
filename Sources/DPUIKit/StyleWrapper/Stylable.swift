import Foundation
import UIKit

public protocol Stylable { }

public extension Stylable {
    
    static func style(style: @escaping Style<Self>) -> Style<Self> { return style }
    
    @discardableResult
    func applyStyles(_ styles: [StyleWrapper<Self>]) -> Self {
        styles.forEach({ style in
            switch style {
            case let .wrap(style):
                style(self)
            }
        })
        
        return self
    }
    
    @discardableResult
    func applyStyles(_ styles: StyleWrapper<Self>...) -> Self {
        self.applyStyles(styles)
    }
    
}

extension NSObject: Stylable {}
