//
//  NewsView.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class NewsView: DPView {
    
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
    
    var news: NewsModel? {
        didSet {
            self.updateComponents()
        }
    }
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.applyStyles(.backgroundColor(AppTheme.cardColor))
        
        UIStackView(arrangedSubviews: [self.titleLabel, self.bodyLabel])
            .applyStyles(.axis(.vertical), .spacing(8), .directionalLayoutMargins(.init(top: 8, leading: 8, bottom: 8, trailing: 8)))
            .addToSuperview(self, withConstraints: [ .edges() ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.titleLabel.text = self.news?.title
        self.bodyLabel.text = self.news?.body
    }
    
}
