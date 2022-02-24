//
//  DPTabBarController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTabBarController: UITabBarController, DPViewProtocol {
    
    // MARK: - Init
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.commonInit()
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        
        self.commonInit()
    }
    
    // MARK: - Props
    open var items: [DPTabBarItem] = []
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
    }
    
    open var selectedItem: DPTabBarItem? {
        get {
            guard self.items.indices.contains(self.selectedIndex) else { return nil }
            return self.items[self.selectedIndex]
        }
        set {
            guard let index = self.items.firstIndex(where: { $0.tag == newValue?.tag }) else { return }
            self.selectedIndex = index
        }
    }
    
    // MARK: - DPViewProtocol
    open func commonInit() {}
    
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
}
