//
//  DPTableSectionHeaderModel.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableSectionHeaderModel {
    
    // MARK: - Init
    public init() {}

    // MARK: - Props
    open var viewClass: AnyClass? {
        nil
    }
    
    open var viewIdentifier: String? {
        #warning("Dev.Append String extension")
        guard let viewClass = self.viewClass else { return nil }
        return String(describing: viewClass.self)
    }

    open var viewHeight: CGFloat {
        UITableView.automaticDimension
    }

    open var viewEstimatedHeight: CGFloat {
        32.0
    }
    
}
