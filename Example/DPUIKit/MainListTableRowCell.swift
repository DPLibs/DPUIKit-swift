//
//  MainListTableRowCell.swift
//  DPUIKit_Example
//
//  Created by Дмитрий Поляков on 29.08.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import DPUIKit

class MainListTableRowCell: DPTableRowCell<MainListTableRowCell.ViewModel> {
    
    // MARK: - Model
    class ViewModel: DPTableRowModel {
        
        // MARK: - Props
        override var cellIdentifier: String? {
            MainListTableRowCell.className
        }
        
        let title: String
        let backgroundColor: UIColor?
        
        // MARK: - Init
        init(title: String) {
            self.title = title
            
            let colors: [UIColor] = [.red, .yellow, .green]
            self.backgroundColor = colors.randomElement()?.withAlphaComponent(0.2)
        }
        
    }
    
    // MARK: - Props
    lazy var titleView: UILabel = {
        let result = UILabel()
        result.font = .systemFont(ofSize: 16)
        result.numberOfLines = 0
        
        return result
    }()
    
    // MARK: - Methods
    override func setupViews() {
        super.setupViews()
        
        self.titleView.removeFromSuperview()
        self.titleView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.titleView)
        
        NSLayoutConstraint.activate([
            self.titleView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.titleView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            self.titleView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.titleView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
    }
    
    override func updateViews() {
        super.updateViews()
        
        self.titleView.text = self.viewModel?.title
        self.contentView.backgroundColor = self.viewModel?.backgroundColor
    }
    
}
