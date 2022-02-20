//
//  String+Extensions.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 29.08.2021.
//

import Foundation

extension String {
    
    static func className(of object: AnyClass) -> String {
        String(describing: object)
    }
    
}
