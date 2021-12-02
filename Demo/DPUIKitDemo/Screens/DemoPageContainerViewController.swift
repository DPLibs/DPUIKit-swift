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
    
    lazy var pageViewController: DPPageContainerViewController = {
        let result = DPPageContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        return result
    }()
    
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        
        self.pageViewController.view.addToSuperview(self.view, withConstraints: [
            .edgesToSuperview()
        ])
        
        let pages = (0...10).map({ self.createPage(number: $0 + 1) })
        self.pageViewController.pages = pages
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let self = self else { return }
//            self.pageViewController.removePages(atRange: .init(0...5), animated: true)
//            self.pageViewController.showPage(at: 4, animated: false)
        }
    }
    
    private func createPage(number: Int) -> UIViewController {
        let page = UIViewController()
        page.view.backgroundColor = .white
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 32)
        label.text = number.description
        
        label.addToSuperview(page.view, withConstraints: [ .centerEqualToSuperview() ])
        
        return page
    }
    
}
