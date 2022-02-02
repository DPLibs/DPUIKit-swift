//
//  DemoTableSectionHeaderView.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 02.02.2022.
//

import Foundation
import UIKit
import DPUIKit

class DemoTableSectionHeaderView: DPTableSectionHeaderView<DemoTableSectionHeaderView.Model> {
     
    class Model: DPTableSectionHeaderModel {
        
        init(title: String) {
            self.title = title
        }
        
        override var viewClass: AnyClass? {
            DemoTableSectionHeaderView.self
        }
        
        override var viewHeight: CGFloat {
            50
        }
        
        let title: String
        
    }
    
    lazy var label: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        result.textColor = .gray
        
        return result
    }()
    
    override func setupComponents() {
        super.setupComponents()
        
        self.label.addToSuperview(self.contentView, withConstraints: [
            .edgesToSuperview(insetsOffset: 16)
        ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.label.text = self.model?.title
    }
    
}

// MARK: - DPTableSectionHeaderModel + DemoTableSectionHeaderView.Model
extension DPTableSectionHeaderModel {
    
    static func demoTableSectionHeaderModel(title: String) -> DemoTableSectionHeaderView.Model {
        .init(title: title)
    }
    
}
