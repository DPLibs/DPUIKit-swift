//
//  DPCollectionItemCellProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

public protocol DPCollectionItemCellProtocol: UICollectionViewCell {
    var _model: DPCollectionItemModelProtocol? { get set }
}
