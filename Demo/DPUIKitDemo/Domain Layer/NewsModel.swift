//
//  NewsModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

struct NewsModel {
    let title: String
    let body: String
}

// MARK: - Moc
extension NewsModel {
    
    static func generate() -> Self {
        .init(
            title: "News",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur quis sem eget placerat. Nunc nisi dolor, malesuada in velit ut, vehicula commodo dui. Fusce fringilla ante non molestie maximus. Aliquam luctus faucibus diam, nec dapibus nunc. Ut non aliquet purus. Donec pellentesque nisl a ligula lobortis, a consectetur leo gravida. Morbi sed sodales mauris. Sed sed ipsum tristique, vulputate sem non, cursus leo. fringilla."
        )
    }
    
}

extension Array where Element == NewsModel {
    
    static func generate(count: Int) -> Self {
        Array(repeating: NewsModel.generate(), count: count)
    }
    
}
