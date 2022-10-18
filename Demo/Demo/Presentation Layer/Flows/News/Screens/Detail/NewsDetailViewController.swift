//
//  NewsDetailViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class NewsDetailViewController: DPViewController {
    
    // MARK: - Init
    init(model: NewsDetailViewModel) {
        super.init()
        
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: NewsDetailViewModel? {
        get { self._model as? NewsDetailViewModel }
        set { self._model = newValue }
    }
    
    lazy var stackScrollView: DPStackScrollView = {
        let result = DPStackScrollView(arrangedSubviews: [self.newsView])
        result.axis = .vertical
        
        return result
    }()
    
    lazy var newsView: NewsView = {
        let result = NewsView()
        result.titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        
        return result
    }()
    
    // MARK: - Methods
    override func loadView() {
        self.view = self.stackScrollView
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
        self.navigationItem.title = self.model?.news.title
        self.newsView.news = self.model?.news
    }
    
}
