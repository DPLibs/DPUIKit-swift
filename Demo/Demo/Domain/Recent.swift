//
//  News.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

struct Recent: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let body: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Moc
extension Recent {
    
    static func moc() -> Self {
        .init(
            title: "News",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur quis sem eget placerat. Nunc nisi dolor, malesuada in velit ut, vehicula commodo dui. Fusce fringilla ante non molestie maximus. Aliquam luctus faucibus diam, nec dapibus nunc. Ut non aliquet purus. Donec pellentesque nisl a ligula lobortis, a consectetur leo gravida. Morbi sed sodales mauris. Sed sed ipsum tristique, vulputate sem non, cursus leo. fringilla."
        )
    }
    
}

extension Array where Element == Recent {
    
    static func moc(count: Int) -> Self {
        (0...count).map({ _ in Recent.moc() })
    }
    
}
