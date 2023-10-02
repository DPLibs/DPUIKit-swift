//
//  DPRepresentableIdentifier.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation

/// Component for generating reuse identifier
public enum DPRepresentableIdentifier {
    
    /// Method for generating a reuse identifier. The `object type` is usually passed as a subject.
    public static func produce<Subject>(_ subject: Subject) -> String {
        String(reflecting: subject)
    }
    
}
