import Foundation
import UIKit

public protocol DPTabBarControllerInput: AnyObject {
    var selectedIndex: Int { get set }
    var selectedItem: DPTabBarItem? { get set }
}
 
open class DPTabBarController: UITabBarController, DPViewProtocol, DPTabBarControllerInput {
    
    // MARK: - Props
    open var items: [DPTabBarItem] = []
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponets()
    }
    
    open var selectedItem: DPTabBarItem? {
        get {
            self.items.first(where: { $0.tag == self.selectedIndex })
        }
        set {
            guard let tag = newValue?.tag, self.items.contains(where: { $0.tag == tag }) else { return }
            
            self.selectedIndex = tag
        }
    }
    
    // MARK: - DPViewProtocol
    open func setupComponets() {}
    
    open func updateComponets() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}
