//
//  NewsListTableRowsCell.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class NewsListTableRowsCell: DPTableRowCell<NewsListTableRowsCell.Model> {
    
    // MARK: - Props
    lazy var titleLabel: UILabel = {
        let result = UILabel()
        result.applyStyles(.textColor(AppTheme.mainColor), .textAlignment(.left), .numberOfLines(0))
        
        return result
    }()
    
    lazy var bodyLabel: UILabel = {
        let result = UILabel()
        result.applyStyles(.textColor(AppTheme.mainColor), .textAlignment(.left), .numberOfLines(0))
        
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        let containerView = UIView()
        containerView.applyStyles(.backgroundColor(AppTheme.cardColor))
        containerView.addToSuperview(self.contentView, withConstraints: [
            .topEqualToSuperview(8),
            .bottomEqualToSuperview(),
            .leadingEqualToSuperview(8),
            .trailingEqualToSuperview(-8)
        ])
        
        let stackView = UIStackView(arrangedSubviews: [self.titleLabel, self.bodyLabel])
        stackView.applyStyles(.axis(.vertical), .spacing(8), .directionalLayoutMargins(.init(top: 8, leading: 8, bottom: 8, trailing: 8)))
        stackView.addToSuperview(containerView, withConstraints: [ .edgesToSuperview() ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.titleLabel.text = self.model?.title
        self.bodyLabel.text = self.model?.body
    }
    
}

// MARK: - Model
extension NewsListTableRowsCell {
    
    class Model: DPTableRowModel {
        
        // MARK: - Init
        init(news: NewsModel) {
            self.title = news.title
            self.body = news.body
            self.news = news
        }
        
        // MARK: - Props
        override var cellIdentifier: String? {
            NewsListTableRowsCell.className
        }
        
        let title: String
        let body: String
        let news: NewsModel?
    }
    
}
