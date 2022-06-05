//
//  DPTableRowCell.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableRowCell<RowModel: DPTableRowModel>: DPTableViewCell {
    
    // MARK: - Props
    open var model: RowModel? {
        get { self._model as? RowModel }
        set { self._model = newValue }
    }
    
}
