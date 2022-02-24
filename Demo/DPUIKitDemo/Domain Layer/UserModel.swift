//
//  UserModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//

import Foundation

struct UserModel {
    
    static func `default`() -> Self {
        .init(firstName: "", lastName: "")
    }
    
    var firstName: String
    var lastName: String
    
    var fio: String {
        "\(self.firstName) \(self.lastName)"
    }
    
    var isFilled: Bool {
        !self.firstName.isEmpty && !self.lastName.isEmpty
    }
    
}
