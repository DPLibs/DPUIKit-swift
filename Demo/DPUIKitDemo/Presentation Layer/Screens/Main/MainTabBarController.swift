//
//  MainTabBarController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class MainTabBarController: DPTabBarController {


    // MARK: - Init
//    init(viewController: [UIViewController], items: [DPTabBarItem]) {
//        super.init()
//
//        self.viewControllers = viewControllers
//        self.items = items
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    // MARK: - Methods
//    override func setupComponents() {
//        super.setupComponents()
//
//        let controllers = DPTabBarItem.TabBarItemType.allCases.map({ type -> (viewController: UIViewController, item: DPTabBarItem) in
//            var rootViewController: UIViewController {
//                switch type {
//                case .news:
//                    return NewsListViewController()
//                case .profile:
//                    let vc = UserInfoViewController(model: .init(user: self.user))
////                    vc.didLogout = { [weak self] in
////                        self?.didLogout?()
////                    }
////                    vc.didUserEdit = { [weak self] user in
////                        self?.didUserEdit?(user)
////                    }
//                    return vc
//                }
//            }
//
//            let item = DPTabBarItem(type: type)
//            let viewController = DPNavigationController(rootViewController: rootViewController)
//            viewController.tabBarItem = item
//
//            return (viewController, item)
//        })
//
//        self.viewControllers = controllers.map({ $0.viewController })
//        self.items = controllers.map({ $0.item })
//    }

}


// MARK: - DPTabBarItem + TabBarItemType
extension DPTabBarItem {

    enum MainTabBarItemType: Int, CaseIterable {
        case news = 0
        case profile = 1
    }

    convenience init(type: MainTabBarItemType) {
        switch type {
        case .news:
            self.init(title: "News", image: nil, tag: type.rawValue)
        case .profile:
            self.init(title: "Profile", image: nil, tag: type.rawValue)
        }
    }

}
