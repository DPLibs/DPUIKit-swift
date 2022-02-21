//
//  UserInfoViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class UserInfoViewController: DPViewController {
    
    // MARK: - Static
    init(model: UserInfoViewModel) {
        super.init()
        
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: UserInfoViewModel? {
        get { self._model as? UserInfoViewModel }
        set { self._model = newValue }
    }
    
    var user: UserModel? {
        get { self.model?.user }
        set { self.model?.user = newValue }
    }
    
    lazy var stackScrollView: DPStackScrollView = {
        let result = DPStackScrollView(arrangedSubviews: [self.firstNameLabel, self.lastNameLabel, .init()])
        result.axis = .vertical
        result.stackView.spacing = 8
        
        return result
    }()
    
    lazy var firstNameLabel: UILabel = {
        UILabel().applyStyles(.textColor(AppTheme.mainColor), .textAlignment(.left), .numberOfLines(0))
    }()
    
    lazy var lastNameLabel: UILabel = {
        UILabel().applyStyles(.textColor(AppTheme.mainColor), .textAlignment(.left), .numberOfLines(0))
    }()
    
    // MARK: - Methods
    override func loadView() {
        self.view = self.stackScrollView
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = AppTheme.background
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.firstNameLabel.text = self.model?.user?.firstName
        self.lastNameLabel.text = self.model?.user?.lastName
    }
    
    override func modelUpdated(_ model: DPViewModel?) {
        super.modelUpdated(model)
        
        self.updateComponents()
    }
    
}
