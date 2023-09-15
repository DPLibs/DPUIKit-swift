//
//  DPTableViewCellProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public protocol DPTableViewCellProtocol: UITableViewCell {
    var _model: DPTableViewCellModelProtocol? { get set }
}
