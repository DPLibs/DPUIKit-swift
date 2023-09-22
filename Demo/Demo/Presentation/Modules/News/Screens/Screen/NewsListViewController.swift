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
    
    private lazy var tableView: DPTableView = {
        let newsAdapter = NewsListTableRowCell.Adapter(
            didSelect: { [weak self] ctx in
                self?.didSelect?(ctx.model.news)
            },
            onCellLeading: { [weak self] _ in
                let actions: [UIContextualAction] = [
                    .init(style: .normal, title: "Info", handler: { [weak self] _, _, handler in
                        handler(true)
                        self?.showInfo()
                    })
                ]
                return .init(actions: actions)
            }
        )
        
        let result = DPTableView()
        result.refreshControl = DPRefreshControl(didBeginRefreshing: { [weak self] in
            self?.model?.reload()
        })
        result.adapter?.addRowAdapters([ newsAdapter ])
        result.adapter?.onDisplayLastRow = { [weak self] in
            self?.model?.loadMore()
        }
        
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "News"
        
        self.tableView.addToSuperview(self.view, withConstraints: [ .edges(to: .safeArea) ])
        self.model?.reload()
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let rows: [DPRepresentableModel] = (self.model?.news ?? []).map({
            NewsListTableRowCell.Model(news: $0)
        })
        
        self.tableView.reloadData([
            DPTableSection(rows: rows)
        ])
    }
    
    override func modelReloaded(_ model: DPViewModel?) {
        super.modelReloaded(model)
        
        self.updateComponents()
    }
    
    override func modelFinishLoading(_ model: DPViewModel?, withError error: Error?) {
        super.modelFinishLoading(model, withError: error)
        
        self.tableView.refreshControl?.endRefreshing()
    }
    
    private func showInfo() {
        let alert = UIAlertController(title: "Info alert", message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
}
