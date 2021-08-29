import Foundation
import UIKit

public protocol DPTabBarControllerInput: AnyObject {
    var selectedIndex: Int { get set }
    var selectedItem: DPTabBarItem? { get set }
}
 
open class DPTabBarController: UITabBarController, DPTabBarControllerInput {
    
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
    
    open func setupComponets() { }
}
