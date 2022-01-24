//
//  DemoMainViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 06.12.2021.
//

import Foundation
import UIKit
import DPUIKit

class DemoMainViewController: DPViewController {
    
    // MARK: - Props
    lazy var stackScrollView: DPStackScrollView = {
        let result = DPStackScrollView()
        result.axis = .vertical
        
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "All Demo"
        let guide = self.view.safeAreaLayoutGuide
        
        self.stackScrollView.addToSuperview(self.view, withConstraints: [
            .leadingEqualTo(guide.leadingAnchor),
            .trailingEqualTo(guide.trailingAnchor),
            .topEqualTo(guide.topAnchor),
            .bottomEqualTo(guide.bottomAnchor)
        ])
        
        let controlles: [UIViewController] = [
            DemoPageContainerViewController(),
            DemoTableViewController()
        ]
        
        let itemsViews: [UIView] = controlles.map({ controller in
            let button = DPButton(type: .system)
            
            let title = String(describing: type(of: controller))
            button.setTitle(title, for: .normal)
            
            button.didTap = { [weak self] in
                self?.navigationController?.pushViewController(controller, animated: true)
            }
            
            return button
        })
        
        self.stackScrollView.addArrangedSubviews(itemsViews + [.init()])
    }
    
}
