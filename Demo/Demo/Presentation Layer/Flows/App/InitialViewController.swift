//
//  InitialViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 23.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class InitialViewController: DPViewController {
    
    // MARK: - Props
    lazy var label: UILabel = {
        UILabel().applyStyles(
            .textColor(AppTheme.mainColor),
            .text("Initial"),
            .textAlignment(.center)
        )
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let result = UIActivityIndicatorView()
        result.color = AppTheme.mainColor
        
        return result
    }()
    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.activity.startAnimating()
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
        
        self.label.applyConstraints(
            .width(100, relation: .greaterThanOrEqual)
        )
        
        UIStackView(arrangedSubviews: [self.activity, self.label])
            .applyStyles(.axis(.vertical), .spacing(8))
            .addToSuperview(self.view, withConstraints: [ .center() ])
    }
    
}
