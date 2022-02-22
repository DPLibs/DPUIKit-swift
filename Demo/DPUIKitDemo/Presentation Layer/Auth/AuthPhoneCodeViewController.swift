//
//  AuthPhoneCodeViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class AuthPhoneCodeViewController: DPViewController {
    
    var didTapConfirm: Closure?
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.navigationItem.title = "Phone code"
        self.view.backgroundColor = AppTheme.background
        
        let codeLabel = UILabel().applyStyles(
            .text("1 1 1 1"),
            .textColor(AppTheme.mainColor),
            .font(.systemFont(ofSize: 36)),
            .textAlignment(.center)
        )
        
        let confirmButton = DPButton(type: .system) { [weak self] in
            self?.didTapConfirm?()
        }.applyStyles(.setTitle("Send code"))
        
        let stackView = UIStackView(arrangedSubviews: [codeLabel, confirmButton])
        stackView.applyStyles(.axis(.vertical), .spacing(8))
        
        stackView.addToSuperview(self.view, withConstraints: [ .centerEqualToSuperview() ])
    }
    
}
