import Foundation
import UIKit

public protocol DPNavigationControllerInput: AnyObject {}

open class DPNavigationController: UINavigationController, DPNavigationControllerInput {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    open func setupComponets() {
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension DPNavigationController: UIGestureRecognizerDelegate {

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}
