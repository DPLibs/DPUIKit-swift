import Foundation
import UIKit

open class DPNavigationController: UINavigationController, DPViewProtocol, UIGestureRecognizerDelegate {
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    // MARK: - DPViewProtocol
    open func setupComponets() {
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    open func updateComponets() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
    // MARK: - UIGestureRecognizerDelegate
    open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
