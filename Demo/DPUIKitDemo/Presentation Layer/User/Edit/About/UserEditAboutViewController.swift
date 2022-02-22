//
//  UserEditAboutViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class UserEditAboutViewController: DPViewController {
    
    // MARK: - Init
    init(model: UserEditAboutViewModel) {
        super.init()
        
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: UserEditAboutViewModel? {
        get { self._model as? UserEditAboutViewModel }
        set { self._model = newValue }
    }
    
    lazy var textView: UITextView = {
        let result = UITextView()
        result.delegate = self
        result.layer.borderColor = AppTheme.mainColor.cgColor
        result.layer.borderWidth = 1
        result.applyConstraints(.heightEqualToConstant(100))
        
        return result
    }()
    
    lazy var doneButton: DPButton = {
        DPButton(type: .system) { [weak self] in
            guard let user = self?.model?.user else { return }
            self?.didTapDone?(user)
        }.applyStyles(.setTitle("Save"))
    }()
    
    var didTapDone: DataClosure<UserModel>?
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.navigationItem.title = "Edit About"
        self.view.backgroundColor = AppTheme.background
        let guide = self.view.safeAreaLayoutGuide
        
        let stackView = UIStackView(arrangedSubviews: [self.textView, self.doneButton, .init()])
        stackView.applyStyles(.axis(.vertical), .spacing(8), .directionalLayoutMargins(.init(top: 16, leading: 16, bottom: 16, trailing: 16)))
        stackView.addToSuperview(self.view, withConstraints: [
            .topEqualTo(guide.topAnchor),
            .bottomEqualTo(guide.bottomAnchor),
            .leadingEqualTo(guide.leadingAnchor),
            .trailingEqualTo(guide.trailingAnchor)
        ])
        
        self.textView.text = self.model?.user.about
    }
    
}

// MARK: - UITextViewDelegate
extension UserEditAboutViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.model?.user.about = textView.text
    }
    
}
