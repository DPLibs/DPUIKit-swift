//
//  DPSearchBarAdapterOutputUI.swift
//  
//
//  Created by Дмитрий Поляков on 10.10.2021.
//

import Foundation
import UIKit

public protocol DPSearchBarAdapterOutputUI: AnyObject {
    func showsCancelButton(_ adapter: DPSearchBarAdapter, isShown: Bool)
    func endEditing(_ adapter: DPSearchBarAdapter)
}

public extension DPSearchBarAdapterOutputUI {
    func showsCancelButton(_ adapter: DPSearchBarAdapter, isShown: Bool) {}
    func endEditing(_ adapter: DPSearchBarAdapter) {}
}
