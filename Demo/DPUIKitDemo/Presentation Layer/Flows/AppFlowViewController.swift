//
//  AppFlowViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation
import DPUIKit
import UIKit

class AppFlowViewController: DPFlowViewController {
    
    // MARK: - Props
    private var isAutorized: Bool {
        get { UserDefaults.standard.bool(forKey: "isAutorized") }
        set { UserDefaults.standard.set(newValue, forKey: "isAutorized") }
    }
    
    private var user: UserModel {
        get {
            let firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
            let lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""
            let about = UserDefaults.standard.string(forKey: "about") ?? ""
            
            return .init(firstName: firstName, lastName: lastName, about: about)
        }
        set {
            UserDefaults.standard.set(newValue.firstName, forKey: "firstName")
            UserDefaults.standard.set(newValue.lastName, forKey: "lastName")
            UserDefaults.standard.set(newValue.about, forKey: "about")
        }
    }
    
    lazy var label: UILabel = {
        let result = UILabel()
        result
            .applyStyles(.textColor(AppTheme.mainColor), .text("Initial"), .textAlignment(.center))
            .applyConstraints(.widthGreaterThanOrEqualToConstant(100))
        
        return result
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
        
        UIStackView(arrangedSubviews: [
            self.activity,
            self.label
        ])
            .applyStyles(.axis(.vertical), .spacing(8))
            .addToSuperview(self.view, withConstraints: [ .centerEqualToSuperview() ])
        
        self.beginFlow()
    }
    
    override func beginFlow() {
        super.beginFlow()
        
        self.rootViewController = nil
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else { return }

            if self.isAutorized {
                if self.user.isFilled {
                    self.showMain()
                } else {
                    self.showUserEdit()
                }
                
            } else {
                self.showAuth()
            }
        }
    }
    
    func showAuth() {
        let vc = AuthFlowViewController()
        vc.didAutorized = { [weak self] in
            self?.isAutorized = true
        }
        vc.didFinishFlow = { [weak self] in
            self?.beginFlow()
        }
        self.rootViewController = vc
    }
    
    func showMain() {
        let vc = MainFlowViewController(user: self.user)
        vc.didFinishFlow = { [weak self] in
            self?.beginFlow()
        }
        self.rootViewController = vc
    }
    
    func showUserEdit() {
        let vc = UserEditFlowViewController(model: .init(user: self.user), useParentNavigation: nil)
        vc.didUserEdited = { [weak self] user in
            self?.user = user
        }
        vc.didFinishFlow = { [weak self] in
            self?.beginFlow()
        }
        self.rootViewController = vc
    }
    
    func userEdited(_ user: UserModel) {
        self.user = user
    }
    
    func logout() {
        self.isAutorized = false
        self.beginFlow()
    }
}

// MARK: - UIViewController + AppFlowViewController
extension UIViewController {
    
    var appFlowViewController: AppFlowViewController? {
        self.findFlow(AppFlowViewController.self)
    }
    
}
