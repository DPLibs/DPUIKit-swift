//
//  DPTableViewHeaderFooterViewModel.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

public protocol DPTableViewHeaderFooterViewModelProtocol {
    var viewClass: DPTableViewHeaderFooterViewProtocol.Type { get }
    var equalIdentifier: String { get }
    var viewHeight: CGFloat { get }
    var viewEstimatedHeight: CGFloat { get }
}

extension DPTableViewHeaderFooterViewModelProtocol {
    var equalIdentifier: String { "" }
    var viewHeight: CGFloat { DPTableConstants.HeaderFooterView.height }
    var viewEstimatedHeight: CGFloat { DPTableConstants.HeaderFooterView.estimatedHeight }
}
