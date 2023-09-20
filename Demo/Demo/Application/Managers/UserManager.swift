//
//  UserMaanger.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.02.2022.
//

import Foundation

class UserManager {
    
    var user: User {
        get {
            let firstName = UserDefaults.standard.string(forKey: "firstName") ?? ""
            let lastName = UserDefaults.standard.string(forKey: "lastName") ?? ""

            return .init(firstName: firstName, lastName: lastName)
        }
        set {
            UserDefaults.standard.set(newValue.firstName, forKey: "firstName")
            UserDefaults.standard.set(newValue.lastName, forKey: "lastName")
        }
    }
    
}
