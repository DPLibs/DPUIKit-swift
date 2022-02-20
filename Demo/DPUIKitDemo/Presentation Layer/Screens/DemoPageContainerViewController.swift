//
//  DemoPageContainerViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 02.12.2021.
//

import Foundation
import UIKit
import DPUIKit

class DemoPageContainerViewController: DPViewController {
    
    // MARK: - Props
    lazy var pageViewController: DPPageContainerViewController = {
        let result = DPPageContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        result.delegate = self
        
        return result
    }()
    
    lazy var showPreviousBarButtonItem: UIBarButtonItem = {
        UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(self.tapShowPrevious))
    }()
    
    lazy var showNextBarButtonItem: UIBarButtonItem = {
        UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(self.tapShowNext))
    }()
    
    lazy var toolBar: UIToolbar = {
        let result = UIToolbar()
        result.items = [
            self.showPreviousBarButtonItem,
            .init(title: "Add to start", style: .plain, target: self, action: #selector(self.tapAddToStart)),
            .init(title: "Remove last", style: .plain, target: self, action: #selector(self.tapRemoveLast)),
            self.showNextBarButtonItem
        ]
        
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "DemoPageViewController"
        let guide = self.view.safeAreaLayoutGuide
        
        self.toolBar.addToSuperview(self.view, withConstraints: [
            .leadingEqualTo(guide.leadingAnchor),
            .trailingEqualTo(guide.trailingAnchor),
            .bottomEqualTo(guide.bottomAnchor)
        ])
        
        self.pageViewController.view.addToSuperview(self.view, withConstraints: [
            .topEqualTo(guide.topAnchor),
            .leadingEqualTo(guide.leadingAnchor),
            .trailingEqualTo(guide.trailingAnchor),
            .bottomEqualTo(self.toolBar.topAnchor)
        ])
        
        self.setPages(numbers: Array(0...9))
        self.updateArrows()
    }
    
    private func setPages(numbers: [Int]) {
        let pages: [UIViewController] =  numbers.map({ number in
            let page = UIViewController()
            page.view.backgroundColor = .white
            
            let label = UILabel()
            label.font = .systemFont(ofSize: 32)
            label.text = "Page \(number + 1)"
            
            label.addToSuperview(page.view, withConstraints: [ .centerEqualToSuperview() ])
            
            return page
        })
        
        self.pageViewController.setPages(pages, animated: true)
    }
    
    @objc
    private func tapShowPrevious () {
        self.pageViewController.showPage(direction: .reverse, animated: true)
    }
    
    @objc
    private func tapAddToStart() {
        let indexSelected = self.pageViewController.pageSelectedIndex
        let numbers = ([-1] + Array(self.pageViewController.pages.indices)).map({ $0 + 1 })
        self.setPages(numbers: numbers)

        guard let index = indexSelected else { return }
        self.pageViewController.showPage(at: index + 1, animated: false)
    }
    
    @objc
    private func tapRemoveLast() {
        self.pageViewController.pages =  Array(self.pageViewController.pages.dropLast())
    }
    
    @objc
    private func tapShowNext () {
        self.pageViewController.showPage(direction: .forward, animated: true)
    }
    
    private func updateArrows() {
        self.showPreviousBarButtonItem.isEnabled = self.pageViewController.pageIsAvalible(forDirection: .reverse)
        self.showNextBarButtonItem.isEnabled = self.pageViewController.pageIsAvalible(forDirection: .forward)
    }
    
}

// MARK: - DPPageContainerViewControllerDelegate
extension DemoPageContainerViewController: DPPageContainerViewControllerDelegate {
    
    func didSelectPage(_ viewController: DPPageContainerViewController, at index: Int) {
        print("[DemoPageContainerViewController] - [didSelectPage] - index:", index)
        self.updateArrows()
    }
    
    func didSetPages(_ viewController: DPPageContainerViewController, pages: [UIViewController]) {
        print("[DemoPageContainerViewController] - [didSetPages] - pages.count:", pages.count)
        self.updateArrows()
    }
    
    func didPageLimitReached(_ viewController: DPPageContainerViewController, for direction: UIPageViewController.NavigationDirection, fromSwipe: Bool) {
        print("[DemoPageContainerViewController] - [didPageLimitReached] - direction:", direction, ", fromSwipe:", fromSwipe)
        self.updateArrows()
    }
    
}
