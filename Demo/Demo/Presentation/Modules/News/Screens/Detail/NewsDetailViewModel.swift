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
    init(news: News) {
        self.news = news
    }
    
    // MARK: - Props
    let news: News
    
}
