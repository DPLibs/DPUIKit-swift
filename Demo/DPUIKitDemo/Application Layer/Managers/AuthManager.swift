//
//  AuthManager.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation

struct AuthManager {
    
    static var isAutorized: Bool {
        get { UserDefaults.standard.bool(forKey: "isAutorized") }
        set { UserDefaults.standard.set(newValue, forKey: "isAutorized") }
    }
}
