//
//  DPTableRowCellProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public protocol DPTableRowCellProtocol: UITableViewCell {
    var _model: DPTableRowModelProtocol? { get set }
}
