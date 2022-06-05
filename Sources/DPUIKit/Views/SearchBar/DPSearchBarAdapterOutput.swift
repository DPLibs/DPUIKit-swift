//
//  DPSearchBarAdapterOutput.swift
//  
//
//  Created by Дмитрий Поляков on 10.10.2021.
//

import Foundation
import UIKit

public protocol DPSearchBarAdapterOutput: AnyObject {
    func tapSearchButton(_ adapter: DPSearchBarAdapter, value: String?)
    func textDidChange(_ adapter: DPSearchBarAdapter, value: String?, isAfterDelay: Bool)
    func tapCancelButton(_ adapter: DPSearchBarAdapter)
    func textMaxLengthAchived(_ adapter: DPSearchBarAdapter, textMaxLength: Int, isAchived: Bool)
}

public extension DPSearchBarAdapterOutput {
    func tapSearchButton(_ adapter: DPSearchBarAdapter, value: String?) {}
    func textDidChange(_ adapter: DPSearchBarAdapter, value: String?, isAfterDelay: Bool) {}
    func tapCancelButton(_ adapter: DPSearchBarAdapter) {}
    func textMaxLengthAchived(_ adapter: DPSearchBarAdapter, textMaxLength: Int, isAchived: Bool) {}
}
