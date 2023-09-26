//
//  MainTabBarController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class MainTabBarController: DPTabBarController {}


// MARK: - DPTabBarItem + TabBarItemType
extension DPTabBarItem {

    enum MainTabBarItemType: Int, CaseIterable {
        case recents = 0
        case profile = 1
    }

    convenience init(type: MainTabBarItemType) {
        switch type {
        case .recents:
            self.init(title: "Recents", image: nil, tag: type.rawValue)
        case .profile:
            self.init(title: "Profile", image: nil, tag: type.rawValue)
        }
    }

}