//
//  RecentViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//

import Foundation
import DPUIKit

class RecentViewModel: DPViewModel {
    
    // MARK: - Init
    init(recent: Recent) {
        self.recent = recent
    }
    
    // MARK: - Props
    let recent: Recent
    
}
