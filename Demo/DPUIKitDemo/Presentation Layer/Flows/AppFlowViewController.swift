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
    var isAutorized: Bool {
        get { UserDefaults.standard.bool(forKey: "isAutorized") }
        set { UserDefaults.standard.set(newValue, forKey: "isAutorized") }
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let self = self else { return }

//            if self.isAutorized {
//                self.showMain()
//            } else {
//                self.showAuth()
//            }
            self.showMain()
        }
    }
    
    func showAuth() {
        let vc = AuthFlowViewController()
        vc.didFinishFlow = { [weak self] in
            self?.beginFlow()
        }
        self.rootViewController = vc
    }
    
    func showMain() {
        let vc = MainFlowViewController()
        vc.didFinishFlow = { [weak self] in
            self?.beginFlow()
        }
        self.rootViewController = vc
    }
}
