//
//  RecentsViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 20.02.2022.
//  Copyright © 2022 AppCraft. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

class RecentsViewController: DPViewController {
    
    // MARK: - Init
    override init() {
        super.init()
        self.model = .init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    var didSelect: ((Recent) -> Void)?
    
    private var model: RecentsViewModel? {
        get { self._model as? RecentsViewModel }
        set { self._model = newValue }
    }
    
    private lazy var tableView: DPTableView = {
        let recentAdapter = RecentTableRowCell.Adapter(
            didSelect: { [weak self] ctx in
                self?.didSelect?(ctx.model)
            },
            onCellLeading: { [weak self] _ in
                return .init(actions: [
                    .init(style: .normal, title: "Info", handler: { [weak self] _, _, handler in
                        handler(true)
                        self?.showInfo()
                    })
                ])
            },
            onCellTrailing: { [weak self] ctx in
                return .init(actions: [
                    .init(style: .destructive, title: "Delete", handler: { [weak self] _, _, handler in
                        handler(true)
                        self?.tableView.adapter?.performBatchUpdates([ .deleteRows(at: [ctx.indexPath], with: .automatic) ])
                    })
                ])
            }
        )
        
        let adapter = DPTableAdapter(rowAdapters: [ recentAdapter ])
        adapter.onDisplayLastRow = { [weak self] in
            self?.model?.loadMore()
        }
        
        let result = DPTableView()
        result.adapter = adapter
        result.refreshControl = DPRefreshControl(didBeginRefreshing: { [weak self] in
            self?.model?.reload()
        })
        
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Recents"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.add))
        
        self.tableView.addToSuperview(self.view, withConstraints: [ .edges(to: .safeArea) ])
        
        self.model?.didAdd = { [weak self] recent, index in
            self?.tableView.adapter?.performBatchUpdates([
                .insertRows([recent], at: [.init(row: 0, section: 0)], with: .fade)
            ])
        }
        
        self.model?.reload()
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let rows = self.model?.recents ?? []
        
        self.tableView.adapter?.reloadData([
            DPRepresentableSection(items: rows)
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
    
}

// MARK: - Private
private extension RecentsViewController {
    
    @objc
    func add() {
        self.model?.add()
    }
    
    func showInfo() {
        let alert = UIAlertController(title: "Info alert", message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
}
