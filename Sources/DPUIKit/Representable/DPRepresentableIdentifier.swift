//
//  DPRepresentableIdentifier.swift
//  Demo
//
//  Created by Дмитрий Поляков on 21.09.2023.
//

import Foundation

public enum DPRepresentableIdentifier {
    
    public static func produce<Subject>(_ subject: Subject) -> String {
        String(reflecting: subject)
    }
    
}
