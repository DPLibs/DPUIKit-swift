//
//  NewsListTableRowsCell.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class NewsListTableRowsCell: DPTableRowCell {
    
    // MARK: - Props
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    lazy var newsView: NewsView = {
        let result = NewsView()
        result.titleLabel.applyStyles(.numberOfLines(2), .lineBreakMode(.byTruncatingTail))
        result.bodyLabel.applyStyles(.numberOfLines(4), .lineBreakMode(.byTruncatingTail))
        
        return result
    }()
    
    // MARK: - Methods
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.newsView.alpha = highlighted ? 0.8 : 1.0
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.newsView.addToSuperview(self.contentView, withConstraints: [
            .edges(.init(top: 8, leading: 8, bottom: 0, trailing: -8))
        ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.newsView.news = self.model?.news
    }
    
}

// MARK: - Model
extension NewsListTableRowsCell {
    
    class Model: DPTableRowModelProtocol {
        
        // MARK: - Init
        init(news: News, onCellLeading: ((DPTableRowContext) -> UISwipeActionsConfiguration?)? = nil) {
            self.news = news
            self.onCellLeading = onCellLeading
        }
        
        // MARK: - Props
        let cellClass: DPTableRowCellProtocol.Type = NewsListTableRowsCell.self
        let news: News
        var onCellLeading: ((DPTableRowContext) -> UISwipeActionsConfiguration?)?
    }
    
}
