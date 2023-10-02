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
        result.titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        return result
    }()
    
    private lazy var stackScrollView: DPStackScrollView = {
        let result = DPStackScrollView(arrangedSubviews: [self.recentView])
        result.axis = .vertical
        return result
    }()
    
    // MARK: - Methods
    override func loadView() {
        self.view = self.stackScrollView
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
        self.navigationItem.title = self.model?.recent.title
        self.recentView.recent = self.model?.recent
    }
    
}
