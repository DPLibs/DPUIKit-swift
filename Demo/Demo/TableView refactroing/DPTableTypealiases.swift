//
//  DPTableTypealizses.swift
//  Demo
//
//  Created by Дмитрий Поляков on 15.09.2023.
//

import Foundation
import UIKit

public typealias DPTableCellContext = (cell: DPTableViewCellProtocol, model: DPTableViewCellModelProtocol, indexPath: IndexPath)
public typealias DPTableCellContextClosure = (DPTableCellContext) -> Void
