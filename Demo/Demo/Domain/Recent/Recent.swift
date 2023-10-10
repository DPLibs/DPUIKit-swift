//
//  News.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

struct Recent: Identifiable, Equatable {
    var id = UUID()
    let title: String
    let body: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
