//
//  DPViewModel.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation

/// Is the source of data and states for ``DPViewController``.
///
/// Part of <doc:MVVM>. 
/// Stores an instance ``DPViewModelOutput`` for notice ``DPViewController``.
/// Сan store and monitor `Model`.
open class DPViewModel {
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Props
    open weak var _output: DPViewModelOutput?
    
    // MARK: - Methods
    open func reload() {}
    open func loadMore() {}
}
