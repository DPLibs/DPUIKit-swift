//
//  DemoTableViewController.swift
//  DPUIKitDemo
//
//  Created by Дмитрий Поляков on 24.01.2022.
//

import Foundation
import UIKit
import DPUIKit

class DemoTableViewController: DPViewController {
    
    private enum Adapter {
        case demo
        case demoSection
    }
    
    // MARK: - Props
    lazy var tableViewController: DPTableViewController = {
        let result = DPTableViewController(_model: .init(), _router: .init(), _errorHandler: .init())
        
//        let refreshControl = DPRefreshControl { [weak self] in
//            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
//                self?.tableViewController.tableView.endRefreshing()
//            }
//        }
//        
//        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
//        result.tableView.refreshControl = refreshControl
        
        return result
    }()
    
    lazy var toolBar: UIToolbar = {
        let result = UIToolbar()
        result.items = [
            .init(title: "A", style: .plain, target: self, action: #selector(self.tapDemoAdapter)),
            .init(title: "S", style: .plain, target: self, action: #selector(self.tapDemoSectionAdapter)),
            .init(title: "C+", style: .plain, target: self, action: #selector(self.tapInsertCenter)),
            .init(title: "E+", style: .plain, target: self, action: #selector(self.tapInsertEnd))
        ]
        
        return result
    }()
    
    private var selectedAdapter: Adapter = .demo {
        didSet {
            guard oldValue != self.selectedAdapter else { return }
            self.updateComponents()
        }
    }
    
    lazy var sectionAdapter: DPTableSectionAdapter = {
        let result = self.createDemoTableSectionAdapter(number: 0)
        result.tableView = self.tableViewController.tableView
        
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "DemoTableViewController"
        let guide = self.view.safeAreaLayoutGuide
        
        self.toolBar.addToSuperview(self.view, withConstraints: [
            .leadingEqualTo(guide.leadingAnchor),
            .trailingEqualTo(guide.trailingAnchor),
            .bottomEqualTo(guide.bottomAnchor)
        ])
        
        self.tableViewController.view.addToSuperview(self.view, withConstraints: [
            .topEqualTo(guide.topAnchor),
            .leadingEqualTo(guide.leadingAnchor),
            .trailingEqualTo(guide.trailingAnchor),
            .bottomEqualTo(self.toolBar.topAnchor)
        ])
    }
    
    override func updateComponents() {
        super.updateComponents()

        switch self.selectedAdapter {
        case .demo:
            let adapter = self.createDemoTableAdapter()
            self.tableViewController.adapter = adapter
        case .demoSection:
            self.tableViewController.adapter = self.sectionAdapter
        }

        self.tableViewController.tableView.reloadData()
    }
    
    @objc
    private func tapDemoAdapter () {
        self.selectedAdapter = .demo
    }
    
    @objc
    private func tapDemoSectionAdapter () {
        self.selectedAdapter = .demoSection
    }
    
    @objc
    private func tapInsertCenter () {
        let rows: [DPTableRowModel] = [
            .demoTableRowModel(),
            .demoTableRowModel(),
            .demoTableRowModel()
        ]
        
        
        self.tableViewController.tableView.performBatchUpdates { [weak self] in
            self?.sectionAdapter.insertRows(rows, at: [3, 4, 5], with: .left)
        } completion: { _ in
            //
        }
    }
    
    @objc
    private func tapInsertEnd () {
        let rows: [DPTableRowModel] = [
            .demoTableRowModel(),
            .demoTableRowModel(),
            .demoTableRowModel()
        ]
        
        self.tableViewController.tableView.performBatchUpdates { [weak self] in
            self?.sectionAdapter.appendRows(rows, with: .bottom)
        } completion: { [weak self] _ in
            guard let self = self else { return }
            
//            guard let last = self.tableViewController.tableView.getLastIndexPath() else { return }
//            self.tableViewController.tableView.scrollToRow(at: last, at: .bottom, animated: true)
        }
        
        guard let last = self.tableViewController.tableView.getLastIndexPath() else { return }
        self.tableViewController.tableView.scrollToRow(at: last, at: .bottom, animated: true)
    }
    
    private func createDemoTableSectionAdapter(number: Int) -> DPTableSectionAdapter {
        .init(
            rows: .generateDemoList(count: 5),
            header: .demoTableSectionHeaderModel(title: "Section \(number) start"),
            footer: .demoTableSectionHeaderModel(title: "Section \(number) end")
        )
    }
    
    private func createDemoTableAdapter() -> DPTableAdapter {
        let sections = (1...5).map({ self.createDemoTableSectionAdapter(number: $0) })
        return .init(sections: sections)
    }
    
}
