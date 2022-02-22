//
//  UserEditAboutViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 22.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import DPUIKit

class UserEditAboutViewModel: DPViewModel {
    
    init(user: UserModel?) {
        self.user = user ?? .default()
    }
    
    var user: UserModel
    
}
