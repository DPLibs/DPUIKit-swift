//
//  RecentView.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//

import Foundation
import DPUIKit
import UIKit

final class RecentView: DPView {
    
    // MARK: - Props
    let titleLabel = UILabel().applyStyles(.textColor(AppTheme.mainColor), .textAlignment(.left), .numberOfLines(0))
    let bodyLabel = UILabel().applyStyles(.textColor(AppTheme.mainColor), .textAlignment(.left), .numberOfLines(0))
    
    var recent: Recent? {
        didSet { self.updateComponents() }
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
        
        self.titleLabel.text = self.recent?.title
        self.bodyLabel.text = self.recent?.body
    }
    
}