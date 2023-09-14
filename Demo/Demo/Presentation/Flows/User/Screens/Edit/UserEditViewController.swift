//
//  UserEditViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class UserEditViewController: DPViewController {
    
    // MARK: - Init
    init(model: UserEditViewModel) {
        super.init()
        
        self.model = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: UserEditViewModel? {
        get { self._model as? UserEditViewModel }
        set { self._model = newValue }
    }
    
    lazy var firstNameTextField: UITextField = {
        let result = UITextField()
        result.applyStyles(.placeholder("FirstName"))
        result.borderStyle = .roundedRect
        result.addTarget(self, action: #selector(self.handleTextFieldEditing(_:)), for: .allEditingEvents)
        
        return result
    }()
    
    lazy var lastNameTextField: UITextField = {
        let result = UITextField()
        result.applyStyles(.placeholder("LastName"))
        result.borderStyle = .roundedRect
        result.addTarget(self, action: #selector(self.handleTextFieldEditing(_:)), for: .allEditingEvents)
        
        return result
    }()
    
    lazy var doneButton: DPButton = {
        DPButton(type: .system) { [weak self] in
            guard let user = self?.model?.user, user.isFilled else { return }
            self?.didTapDone?(user)
        }.applyStyles(.setTitle("Next"))
    }()
    
    var didTapDone: ((UserModel) -> Void)?
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.navigationItem.title = "Edit User"
        self.view.backgroundColor = AppTheme.background
        
        UIStackView(arrangedSubviews: [self.firstNameTextField, self.lastNameTextField, self.doneButton, .init()])
            .applyStyles(
                .axis(.vertical),
                .spacing(8),
                .directionalLayoutMargins(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
            )
            .addToSuperview(self.view, withConstraints: [
                .edges(to: .safeArea)
            ])
        
        self.firstNameTextField.text = self.model?.user.firstName
        self.lastNameTextField.text = self.model?.user.lastName
    }
    
    @objc
    private func handleTextFieldEditing(_ textField: UITextField) {
        let text = textField.text ?? ""
        
        switch textField {
        case self.firstNameTextField:
            self.model?.user.firstName = text
        case self.lastNameTextField:
            self.model?.user.lastName = text
        default:
            return
        }
    }

}
