//
//  NewsListViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

struct Test1: DPRepresentableModel {
    
}

class Test2: DPRepresentableModel {
    
    struct Test3: DPRepresentableModel {}
    
    class Test4: DPRepresentableModel {}
}

class NewsListViewController: DPViewController {
    
    // MARK: - Init
    override init() {
        super.init()
        
        self.model = .init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    var didSelect: ((News) -> Void)?
    
    private var model: NewsListViewModel? {
        get { self._model as? NewsListViewModel }
        set { self._model = newValue }
    }
    
    lazy var tableView: DPTableView = {
        let result = DPTableView()
        result.adapter?.onDisplayLastRow = { [weak self] in
            self?.model?.loadMore()
        }
        result.adapter?.didSelectRow = { [weak self] ctx in
            guard let model = ctx.model as? NewsListTableRowsCell.Model else { return }
            self?.didSelect?(model.news)
        }
        
        return result
    }()
    
    // MARK: - Methods
    override func loadView() {
        self.view = self.tableView
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.navigationItem.title = "News"
        self.model?.reload()
        
        let test1 = Test1()
        let test2 = Test2()
        let test3 = Test2.Test3()
        let test4 = Test2.Test4()
        
        print("!!!", test1._representableIdentifier, test2._representableIdentifier, test3._representableIdentifier, test4._representableIdentifier)
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let news = self.model?.news ?? []
        let rows: [DPTableRowModelProtocol] = news.map({
            NewsListTableRowsCell.Model(news: $0)
            {[weak self] ctx in
                    let actions: [UIContextualAction] = [
                        .init(style: .normal, title: "Info", handler: { [weak self] _, _, handler in
                            handler(true)
                            self?.showInfo()
                        })
                    ]
                    return .init(actions: actions)
                }
        })
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData([ DPTableSection(rows: rows) ])
        }
        
    }
    
    override func modelReloaded(_ model: DPViewModel?) {
        self.updateComponents()
    }
    
    private func showInfo() {
        let alert = UIAlertController(title: "Info alert", message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
}
