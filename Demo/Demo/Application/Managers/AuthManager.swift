//
//  AuthManager.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation
import DPUIKit

class AuthManager {
    
    // MARK: - Props
    var isAutorized: Bool {
        get { UserDefaults.standard.bool(forKey: "isAutorized") }
        set { UserDefaults.standard.set(newValue, forKey: "isAutorized") }
    }
    
    var didLogout: (() -> Void)?
    
    // MARK: - LoginHandlder
    func login() {
        self.isAutorized = true
    }
    
    func logout() {
        self.isAutorized = false
        self.didLogout?()
    }
}
