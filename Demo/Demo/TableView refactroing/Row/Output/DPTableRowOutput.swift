//
//  DPTableViewCellOutput.swift
//  Demo
//
//  Created by Дмитрий Поляков on 18.09.2023.
//

import Foundation

public struct DPTableRowOutput: DPTableRowOutputProtocol {
    public var didSelect: DPTableCellContextClosure?
    public var didDeselect: DPTableCellContextClosure?
    public var onCell: DPTableCellContextClosure?
    public var willDisplay: DPTableCellContextClosure?
    public var willBeginEditing: DPTableCellContextClosure?
    public var didEndEditing: DPTableCellContextClosure?
    public var onCellLeading: DPTableCellContextToSwipeActionsConfiguration?
    public var onCellTrailing: DPTableCellContextToSwipeActionsConfiguration?
}
