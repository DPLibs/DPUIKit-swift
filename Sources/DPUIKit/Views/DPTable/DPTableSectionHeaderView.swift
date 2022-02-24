//
//  DPTableSectionHeaderView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableSectionHeaderView<SectionHeaderModel: DPTableSectionHeaderModel>: DPTableViewHeaderFooterView {
    
    // MARK: - Props
    open var model: SectionHeaderModel? {
        get {
            self._model as? SectionHeaderModel
        }
        set {
            self._model = newValue
        }
    }
    
}
