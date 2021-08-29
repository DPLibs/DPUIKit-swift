import Foundation

extension String {
    
    static func className(of object: AnyClass) -> String {
        String(describing: object)
    }
    
}
