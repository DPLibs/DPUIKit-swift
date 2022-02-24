//
//  NSMutableAttributedString+Extensions.swift
//  
//
//  Created by Дмитрий Поляков on 11.10.2021.
//

import Foundation

public extension NSMutableAttributedString {
    
    /// Create mutableAttributedString from string.
    /// - Parameter string: String for create.
    /// - Parameter styles: Styles for created mutableAttributedString.
    /// - Returns: Created mutableAttributedString with styles.
    ///
    static func createFromString(_ string: String, with styles: [StyleWrapper<NSMutableAttributedString>]) -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: string)
        mutableAttributedString.applyStyles(array: styles)
        return mutableAttributedString
    }
    
}
