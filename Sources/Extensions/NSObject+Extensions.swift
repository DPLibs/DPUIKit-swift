//
//  NSObject+Extensions.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 29.08.2021.
//

import Foundation

#warning("Dev.Refactoring")
public extension NSObject {

    class var className: String {
//        NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        String(describing: self)
    }
    
    var className: String {
        String(describing: self)
    }

}
