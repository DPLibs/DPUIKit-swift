//
//  Coordinator.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 03.02.2022.
//

import Foundation
import UIKit
import DPUIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        let label = UILabel()
        label.numberOfLines = 0
        label.text = String(describing: self)
        label.textAlignment = .center
        
        label.addToSuperview(self.view, withConstraints: [
            .centerEqualToSuperview(),
            .leadingEqualToSuperview(24),
            .trailingEqualToSuperview(-24)
        ])
    }
    
}

class FlowViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    func start() {}
}

class AppFlowViewController: FlowViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("!!! AppFlowViewController", self.parent)
    }
    
    var isAutoprized: Bool {
        get { UserDefaults.standard.bool(forKey: "isAutoprized") }
        set {
            UserDefaults.standard.set(newValue, forKey: "isAutoprized")
            self.start()
        }
    }
    
    override func start() {
        self.children.forEach({
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        })
        
        if isAutoprized {
            let vc = MainFlowCireController()
            self.add(vc)
        } else {
            let vc = AuthFlowViewController()
            vc.didAutorized = { [weak self] in
                self?.isAutoprized = true
            }
            self.add(vc)
        }
        
    }
    
}

class AuthFlowViewController: FlowViewController {
    
    var didAutorized: (() -> Void)?
    
    private let navigation: UINavigationController = .init()
    
    override func start() {
        self.add(navigation)
        self.showPhone()
    }
    
    private func showPhone() {
        let vc = PhoneAuthViewController()
        vc.didTapCode = { [weak self] in
            self?.showCode()
        }
        self.navigation.pushViewController(vc, animated: false)
    }
    
    private func showCode() {
        let vc = CodeAuthViewController()
        vc.didConfirm = { [weak self] in
            self?.didAutorized?()
        }
        self.navigation.pushViewController(vc, animated: true)
    }
}

class PhoneAuthViewController: BaseViewController {
    
    var didTapCode: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = DPButton(type: .system)
        button.setTitle("Show code", for: .normal)
        button.didTap = { [weak self] in
            self?.didTapCode?()
        }
        
        button.addToSuperview(self.view, withConstraints: [
            .centerXEqualToSuperview(),
            .bottomEqualToSuperview(-100)
        ])
    }
    
}

class CodeAuthViewController: BaseViewController {
    
    var didConfirm: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = DPButton(type: .system)
        button.setTitle("Confirm", for: .normal)
        button.didTap = { [weak self] in
            self?.didConfirm?()
        }
        
        button.addToSuperview(self.view, withConstraints: [
            .centerXEqualToSuperview(),
            .bottomEqualToSuperview(-100)
        ])
    }
    
}

class MainFlowCireController: FlowViewController {
    
    private let tabBar = AppTabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("!!! MainFlowCireController", self.parent)
        
    }
    
    override func start() {
        self.add(tabBar)
    }
    
}

class AppTabBarController: DPTabBarController {
    
    override func setupComponents() {
        super.setupComponents()
        
        let dashboardItem: DPTabBarItem = .dashboard()
        let dashboardVC = UINavigationController(rootViewController: DashboardViewController())
        dashboardVC.tabBarItem = dashboardItem
        
        let historyItem: DPTabBarItem = .history()
        let histotyVC = UINavigationController(rootViewController: HistoryViewController())
        histotyVC.tabBarItem = historyItem
        
        let profileItem: DPTabBarItem = .profile()
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.tabBarItem = profileItem
        
        self.items = [dashboardItem, historyItem, profileItem]
        self.viewControllers = [dashboardVC, histotyVC, profileVC]
    }
    
}

class DashboardViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("!!! DashboardViewController", self.parent, self.findFlow(AppFlowViewController.self))
        
    }
}

class HistoryViewController: BaseViewController {}


class ProfileViewController: BaseViewController {}

extension DPTabBarItem {
    
    static func dashboard() -> DPTabBarItem {
        .init(title: "dashboard", image: nil, tag: 0)
    }
    
    static func history() -> DPTabBarItem {
        .init(title: "history", image: nil, tag: 1)
    }
    
    static func profile() -> DPTabBarItem {
        .init(title: "profile", image: nil, tag: 2)
    }
    
}

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func findFlow<T: FlowViewController>(_ type: T.Type) -> T? {
        guard let parent = self.parent else { return nil }
        
        if let flow = parent as? T {
            return flow
        } else {
            return parent.findFlow(T.self)
        }
    }
}
