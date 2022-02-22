//
//  UserEditFlowViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//

import Foundation
import DPUIKit

class UserEditFlowViewModel: DPViewModel {
    
    init(user: UserModel?) {
        self.user = user ?? .default()
    }
    
    var user: UserModel
    
}
