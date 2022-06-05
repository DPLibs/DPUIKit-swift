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
    open weak var _output: DPViewModelOutput?
    
    // MARK: - Methods
    open func reload() {}
    open func loadMore() {}
}
