//
//  DPViewErrorHandler.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPViewErrorHandler {
    
    // MARK: - Props
    open weak var viewController: UIViewController?
    
    // MARK: - Init
    public init() {}
    
    // MARK: - Methods
    open func handleError(_ error: Error?, completion: (() -> Void)? = nil) {
        guard let error = error else { return }
        
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        
        self.viewController?.present(alert, animated: true, completion: completion)
    }
}
