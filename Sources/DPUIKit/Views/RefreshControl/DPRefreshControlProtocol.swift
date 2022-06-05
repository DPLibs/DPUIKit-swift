//
//  DPRefreshControlProtocol.swift
//  
//
//  Created by Дмитрий Поляков on 03.02.2022.
//

import Foundation

public protocol DPRefreshControlProtocol {
    var isRefreshing: Bool { get }
    
    func beginRefreshing()
    func endRefreshing()
}
