//
//  RecentViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

final class RecentViewController: DPViewController {
    
    // MARK: - Init
    init(model: RecentViewModel) {
        super.init()
        
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: RecentViewModel? {
        get { self._model as? RecentViewModel }
        set { self._model = newValue }
    }
    
    private lazy var recentView: RecentView = {
        let result = RecentView()
        result.titleLabel.isHidden = true
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
        self.navigationItem.title = self.model?.recent.title
        
        let recentContainerView: UIView = {
            let result = UIView()
            
            self.recentView.addToSuperview(result, withConstraints: [
                .edges(.init(top: 16, leading: 16, bottom: -16, trailing: -16))
            ])
            
            return result
        }()
        
        let stackScrollView: DPStackScrollView = {
            let result = DPStackScrollView(arrangedSubviews: [recentContainerView])
            result.axis = .vertical
            return result
        }()
        
        stackScrollView.addToSuperview(self.view, withConstraints: [ .edges(to: .safeArea) ])
        
        self.recentView.recent = self.model?.recent
    }
    
}
