//
//  AuthPhoneViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class AuthPhoneViewController: DPViewController {
    
    var didTapConfirm: Closure?
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.navigationItem.title = "Phone"
        self.view.backgroundColor = AppTheme.background
        
        let phoneLabel = UILabel().applyStyles(
            .text("+7 (900) 900 9090"),
            .textColor(AppTheme.mainColor),
            .font(.systemFont(ofSize: 36)),
            .textAlignment(.center)
        )
        
        let confirmButton = DPButton(type: .system) { [weak self] in
            self?.didTapConfirm?()
        }.applyStyles(.setTitle("Next"))
        
        let stackView = UIStackView(arrangedSubviews: [phoneLabel, confirmButton])
        stackView.applyStyles(.axis(.vertical), .spacing(8))
        
        stackView.addToSuperview(self.view, withConstraints: [ .centerEqualToSuperview() ])
    }
    
}
