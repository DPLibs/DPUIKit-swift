//
//  UserModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//

import Foundation

struct UserModel {
    let firstName: String
    let lastName: String
    
    var fio: String {
        "\(self.firstName) \(self.lastName)"
    }
    
}
