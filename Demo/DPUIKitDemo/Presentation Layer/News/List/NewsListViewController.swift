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
        self.router = .init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: NewsListViewModel? {
        get { self._model as? NewsListViewModel }
        set { self._model = newValue }
    }
    
    private var router: NewsListViewRouter? {
        get { self._router as? NewsListViewRouter }
        set { self._router = newValue }
    }
    
    lazy var tableView: DPTableView = {
        let result = DPTableView()
        result.registerCellClasses([ NewsListTableRowsCell.self ])
        result.dataOutput = self
        
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
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let news = self.model?.news ?? []
        let rows: [DPTableRowModel] = news.map({ NewsListTableRowsCell.Model(news: $0) })
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData(with: [ .init(rows: rows) ])
        }
        
    }
    
    override func modelReloaded(_ model: DPViewModel?) {
        self.updateComponents()
    }
    
}

// MARK: - DPTableDataOutput
extension NewsListViewController: DPTableDataOutput {
    
    func bottomAchived(_ tableView: DPTableView) {
        self.model?.loadMore()
    }
    
    func selectRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell, row: DPTableRowModel) {
        guard let model = row as? NewsListTableRowsCell.Model else { return }
        self.router?.showNewsDetail(news: model.news)
    }
    
}
