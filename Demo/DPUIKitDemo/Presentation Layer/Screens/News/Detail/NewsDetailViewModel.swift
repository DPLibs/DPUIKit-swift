//
//  NewsDetailViewModel.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 21.02.2022.
//

import Foundation
import DPUIKit

class NewsDetailViewModel: DPViewModel {
    
    // MARK: - Init
    init(news: NewsModel) {
        self.news = news
    }
    
    // MARK: - Props
    let news: NewsModel
    
}
