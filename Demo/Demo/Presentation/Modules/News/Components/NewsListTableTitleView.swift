//
//  NewsListTableTitleView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation
import UIKit
import DPUIKit

final class NewsListTableTitleView: DPTableTitleView {
    
    var model: Model? {
        get { self._model as? Model }
        set { self._model = newValue }
    }
    
    let label = UILabel()
    
    override func setupComponents() {
        super.setupComponents()
        
        self.label.textAlignment = .left
        self.label.addToSuperview(self.contentView, withConstraints: [ .edges() ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.label.text = self.model?.title
    }
    
}

extension NewsListTableTitleView {
    
    typealias Adapter = DPTableTitleAdapter<NewsListTableTitleView, Model>
    
    struct Model: DPRepresentableModel {
        let title: String
    }
    
}
