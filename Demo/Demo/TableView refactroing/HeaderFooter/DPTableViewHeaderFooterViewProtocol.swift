//
//  DPTableViewHeaderFooterViewProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public protocol DPTableViewHeaderFooterViewProtocol: UITableViewHeaderFooterView {
    var _model: DPTableViewHeaderFooterViewModelProtocol? { get set }
}
