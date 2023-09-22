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
        result.adapter?.addRowAdapters([
            NewsListTableRowsCell.Adapter(
//                cellHeight: 300,
//                didSelect: { [weak self] ctx in
//                    self?.didSelect?(ctx.model.news)
//                },
//                onCellLeading: { [weak self] ctx in
//                    let actions: [UIContextualAction] = [
//                        .init(style: .normal, title: "Info", handler: { [weak self] _, _, handler in
//                            handler(true)
//                            self?.showInfo()
//                        })
//                    ]
//                    return .init(actions: actions)
//                }
            )
        ])
        result.adapter?.addTitleAdapters([
            NewsListTableTitleView.Adapter(viewHeight: 100)
        ])
        result.adapter?.onDisplayLastRow = { [weak self] in
//            self?.model?.loadMore()
        }
        
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "News"
        
        self.tableView.backgroundColor = .red
        self.tableView.addToSuperview(self.view, withConstraints: [ .edges(to: .safeArea) ])
        
        self.model?.reload()
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let rows: [DPRepresentableModel] = (self.model?.news ?? []).map({
            NewsListTableRowsCell.Model(news: $0)
        })
        
        self.tableView.reloadData([
            DPTableSection(
                rows: rows
//                header: NewsListTableTitleView.Model(title: "HEADER"),
//                footer: NewsListTableTitleView.Model(title: "FOOTER")
            )
        ])
        
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
