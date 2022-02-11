//
//  DemoTableRowCell.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 02.02.2022.
//

import Foundation
import UIKit
import DPUIKit

class DemoTableRowCell: DPTableRowCell<DemoTableRowCell.Model> {
    
    class Model: DPTableRowModel {
        
        init(title: String = UUID().uuidString) {
            self.title = title
        }
        
        override var cellClass: AnyClass? {
            DemoTableRowCell.self
        }
        
        let title: String
    }
    
    lazy var label: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        result.textColor = .black
        
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

// MARK: - DPTableRowModel + DemoTableRowCell.Model
extension DPTableRowModel {
    
    static func demoTableRowModel() -> DemoTableRowCell.Model {
        .init()
    }
    
}

// MARK: - Array + DemoTableRowCell.Model
extension Array where Element == DPTableRowModel {
    
    static func generateDemoList(count: Int) -> [Element] {
        (0...count).map({ _ in .demoTableRowModel() })
    }
    
}
