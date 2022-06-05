//
//  DPTabBarController.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTabBarController: UITabBarController, DPViewProtocol, DPCoordinatableViewController {
    
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
    public var items: [UITabBarItem?] {
        (self.viewControllers ?? []).map({ $0.tabBarItem })
    }
    
    open var selectedItem: UITabBarItem? {
        get {
            guard self.items.indices.contains(self.selectedIndex) else { return nil }
            return self.items[self.selectedIndex]
        }
        set {
            guard let index = self.items.firstIndex(where: { $0?.tag == newValue?.tag }) else { return }
            self.selectedIndex = index
        }
    }
    
    // MARK: - Methods
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupComponents()
    }
    
    // MARK: - DPViewProtocol
    open func commonInit() {}
    
    open func setupComponents() {}
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    // MARK: - DPCoordinatableViewController
    open var coordinator: DPCoordinatorProtocol?
    
}
