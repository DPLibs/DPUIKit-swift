//
//  DPViewModel.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation

open class DPViewModel {
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Props
    var didError: ((Error) -> Void)?
    var didBeginLoading: (() -> Void)?
    var didFinishLoading: (() -> Void)?
    
}
