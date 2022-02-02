//
//  DPTableViewProtocol.swift
//  
//
//  Created by Дмитрий Поляков on 20.01.2022.
//

import Foundation
import UIKit

public protocol DPTableViewProtocol: DPViewProtocol {
    var dataSource: UITableViewDataSource? { get set }
    var delegate: UITableViewDelegate? { get set }
    
    func beginRefreshing()
    func endRefreshing()
}
