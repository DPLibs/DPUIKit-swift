//
//  NSObject.swift
//  DPTestProject_UIKit
//
//  Created by Дмитрий Поляков on 29.08.2021.
//

import Foundation

public extension NSObject {

    class var className: String {
        NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

}
