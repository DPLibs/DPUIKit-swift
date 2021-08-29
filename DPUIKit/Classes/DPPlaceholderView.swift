import Foundation
import UIKit

open class DPPlaceholderView: DPView {
    
    open func setHidden(_ hidden: Bool, animated: Bool) {
        guard self.isHidden != hidden else { return }
        
        self.isHidden = true
    }
    
}
