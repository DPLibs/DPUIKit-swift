//
//  UserEditViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//

import Foundation
import DPUIKit

class UserEditViewModel: DPViewModel {
    
    init(user: User?) {
        self.user = user ?? .default()
    }
    
    var user: User
    
}
