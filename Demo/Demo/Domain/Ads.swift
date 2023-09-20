//
//  Ads.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation

struct Ads {
    let title: String
    let body: String
}

// MARK: - Moc
extension Ads {
    
    static func moc() -> Self {
        .init(
            title: "Ads",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur quis sem eget placerat. Nunc nisi dolor, malesuada in velit ut, vehicula commodo dui. Fusce fringilla ante non molestie maximus. Aliquam luctus faucibus diam, nec dapibus nunc. Ut non aliquet purus. Donec pellentesque nisl a ligula lobortis, a consectetur leo gravida. Morbi sed sodales mauris. Sed sed ipsum tristique, vulputate sem non, cursus leo. fringilla."
        )
    }
    
}

extension Array where Element == Ads {
    
    static func moc(count: Int) -> Self {
        Array(repeating: Ads.moc(), count: count)
    }
    
}
