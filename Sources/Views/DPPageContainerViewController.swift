//
//  DPPageContainerViewController.swift
//  
//
//  Created by Дмитрий Поляков on 08.10.2021.
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

open class DPPageContainerViewController: DPViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    public typealias Completion = (Bool) -> Void
    
    // MARK: - Init
    public convenience init(
        transitionStyle style: UIPageViewController.TransitionStyle,
        navigationOrientation: UIPageViewController.NavigationOrientation,
        options: [UIPageViewController.OptionsKey: Any]? = nil,
        _model: DPViewModel = .init(),
        _router: DPViewRouter = .init(),
        _errorHandler: DPViewErrorHandler = .init()
    ) {
        self.init(_model: _model, _router: _router, _errorHandler: _errorHandler)
        
        self.pageViewController = UIPageViewController(transitionStyle: style, navigationOrientation: navigationOrientation, options: options)
        self.pageViewControllerDidSet()
    }
    
    // MARK: - Props
    open weak var delegate: DPPageContainerViewControllerDelegate?
    
    open var pages: [UIViewController] = [] {
        didSet {
            self.delegate?.didSetPages(self, pages: self.pages)
            self.showPage(at: self.pageSelectedIndex ?? 0, animated: false)
        }
    }
    
    open var pageViewController: UIPageViewController = .init() {
        didSet {
            oldValue.view.removeFromSuperview()
            oldValue.removeFromParent()
            
            self.pageViewControllerDidSet()
        }
    }
    
    open var swipeIsEnabled: Bool = true {
        didSet {
            self.swipeIsEnabledDidSet()
        }
    }
    
    open private(set) var pageSelectedIndex: Int?
    
    public var pageSelected: UIViewController? {
        guard let index = self.pageSelectedIndex, self.pages.indices.contains(index) else { return nil }
        
        return self.pages[index]
    }
    
    // MARK: - Methods
    open override func commonInit() {
        super.commonInit()
        
        self.pageViewControllerDidSet()
    }
    
    open func pageViewControllerDidSet() {
        self.pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.pageViewController.view)
        
        NSLayoutConstraint.activate([
            self.pageViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.pageViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.pageViewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.pageViewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.addChild(self.pageViewController)
        self.pageViewController.delegate = self
        
        self.swipeIsEnabledDidSet()
        self.showPage(at: self.pageSelectedIndex ?? 0, animated: false)
    }
    
    open func swipeIsEnabledDidSet() {
        self.pageViewController.dataSource = self.swipeIsEnabled ? self : nil
    }
    
    open func showPage(at index: Int, animated: Bool, completion: Completion? = nil) {
        var indexForSelectOptional: Int? {
            if self.pages.indices.contains(index) {
                return index
            } else if self.pages.indices.contains(self.pages.count - 1) {
                return self.pages.count - 1
            } else {
                return nil
            }
        }
        
        guard let indexForSelect = indexForSelectOptional else {
            completion?(false)
            self.pageSelectedIndex = nil
            self.pageViewController.setViewControllers([UIViewController()], direction: .forward, animated: false, completion: completion)
            self.pageViewController.dataSource = nil
            return
        }
        
        if self.swipeIsEnabled {
            self.pageViewController.dataSource = self
        }
        
        let controller = self.pages[indexForSelect]
        let direction: UIPageViewController.NavigationDirection = indexForSelect >= (self.pageSelectedIndex ?? 0) ? .forward : .reverse
        self.pageSelectedIndex = indexForSelect

        self.pageViewController.setViewControllers([controller], direction: direction, animated: animated, completion: { [weak self] completed in
            guard let self = self, completed else { return }
            
            self.delegate?.didSelectPage(self, at: indexForSelect)
            completion?(true)
        })
    }
    
    open func setPages(_ pages: [UIViewController], animated: Bool, showPageAtIndex index: Int? = nil, completion: Completion? = nil) {
        self.pages = pages
        self.showPage(at: index ?? self.pageSelectedIndex ?? 0, animated: animated, completion: completion)
    }
    
    open func showPage(direction: UIPageViewController.NavigationDirection, animated: Bool, completion: Completion? = nil) {
        guard let index = self.generateNextIndex(forDirection: direction) else {
            completion?(false)
            return
        }
        
        guard self.pages.indices.contains(index) else {
            self.delegate?.didPageLimitReached(self, for: direction, fromSwipe: false)
            completion?(false)
            return
        }
        
        self.showPage(at: index, animated: animated, completion: completion)
    }
    
    open func pageIsAvalible(forDirection direction: UIPageViewController.NavigationDirection) -> Bool {
        guard let index = self.generateNextIndex(forDirection: direction) else { return false }
        return self.pages.indices.contains(index)
    }
    
    open func generateNextIndex(forDirection direction: UIPageViewController.NavigationDirection) -> Int? {
        switch direction {
        case .forward:
            return (self.pageSelectedIndex ?? 0) + 1
        case .reverse:
            return (self.pageSelectedIndex ?? 0) - 1
        @unknown default:
            return nil
        }
    }

//    open func removePages(atRange range: Range<Int>, animated: Bool) {
//        self.pages.removeSubrange(range)
//        
//        let index = self.pageSelectedIndex ?? self.pages.count - 1
//        self.showPage(at: index, animated: animated)
//    }
    
    
    // MARK: - UIPageViewControllerDelegate
    open func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let index = self.pages.firstIndex(where: { $0 == pageViewController.viewControllers?.first }) {
            self.pageSelectedIndex = index
            self.delegate?.didSelectPage(self, at: index)
        }
    }
    
    // MARK: - UIPageViewControllerDataSource
    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.pages.firstIndex(where: { $0 == viewController }), self.pages.indices.contains(index - 1) else {
            self.delegate?.didPageLimitReached(self, for: .reverse, fromSwipe: true)
            return nil
        }

        return self.pages[index - 1]
    }

    open func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.pages.firstIndex(where: { $0 == viewController }), self.pages.indices.contains(index + 1) else {
            self.delegate?.didPageLimitReached(self, for: .forward, fromSwipe: true)
            return nil
        }

        return self.pages[index + 1]
    }
    
}
