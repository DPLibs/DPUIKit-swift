//
//  DPPageContainerViewControllerDelegate.swift
//  
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import UIKit

public protocol DPPageContainerViewControllerDelegate: AnyObject {
    func didSelectPage(_ viewController: DPPageContainerViewController, at index: Int)
    func didSetPages(_ viewController: DPPageContainerViewController, pages: [UIViewController])
    func didPageLimitReached(_ viewController: DPPageContainerViewController, for direction: UIPageViewController.NavigationDirection, fromSwipe: Bool)
}

public extension DPPageContainerViewControllerDelegate {
    func didSelectPage(_ viewController: DPPageContainerViewController, at index: Int) {}
    func didSetPages(_ viewController: DPPageContainerViewController, pages: [UIViewController]) {}
    func didPageLimitReached(_ viewController: DPPageContainerViewController, for direction: UIPageViewController.NavigationDirection, fromSwipe: Bool) {}
}
