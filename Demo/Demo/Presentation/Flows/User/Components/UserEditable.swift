//
//  UserEditable.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 05.06.2022.
//

import Foundation

protocol UserEditable: AnyObject {
    func setUser(_ user: UserModel)
}
