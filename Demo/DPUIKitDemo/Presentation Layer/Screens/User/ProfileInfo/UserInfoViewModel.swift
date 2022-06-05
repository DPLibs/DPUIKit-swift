//
//  UserInfoViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import DPUIKit

class UserInfoViewModel: DPViewModel {
    
    init(user: UserModel?) {
        self.user = user
    }
    
    var user: UserModel? {
        didSet { self._output?.modelUpdated(self) }
    }
}
