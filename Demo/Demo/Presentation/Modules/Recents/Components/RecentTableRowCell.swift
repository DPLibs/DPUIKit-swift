//
//  RecentTableRowCell.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit
import UIKit

final class RecentTableRowCell: DPTableRowCell {
    
    // MARK: - Props
    var model: Recent? {
        get { self._model as? Recent }
        set { self._model = newValue }
    }
    
    private lazy var recentView: RecentView = {
        let result = RecentView()
        result.titleLabel.applyStyles(.numberOfLines(2), .lineBreakMode(.byTruncatingTail))
        result.bodyLabel.applyStyles(.numberOfLines(4), .lineBreakMode(.byTruncatingTail))
        return result
    }()
    
    // MARK: - Methods
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        self.recentView.alpha = highlighted ? 0.8 : 1.0
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.recentView.addToSuperview(self.contentView, withConstraints: [
            .edges(.init(top: 16, leading: 16, bottom: -16, trailing: -16))
        ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.recentView.recent = self.model
    }
    
}

// MARK: - Model
extension RecentTableRowCell {
    typealias Adapter = DPTableRowAdapter<RecentTableRowCell, Recent>
}
