//
//  DPViewErrorHandler.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

/// Needed to process and display errors.
///
/// Part of <doc:MVVM>. 
/// Stores a link to `UIViewController` for show errors.
open class DPViewErrorHandler {
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Props
    open weak var viewController: UIViewController?
    
    // MARK: - Methods
    open func handleError(_ error: Error, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        self.viewController?.present(alert, animated: true, completion: completion)
    }
}
