//
//  NewsListViewRouter.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import DPUIKit

class NewsListViewRouter: DPViewRouter {
    
    func showNewsDetail(news: NewsModel) {
        let vc = NewsDetailViewController(model: .init(news: news))
        self.push(viewController: vc, animated: true)
    }
    
}
