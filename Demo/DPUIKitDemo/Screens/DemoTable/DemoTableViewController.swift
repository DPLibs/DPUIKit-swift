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
//            //
//        }
        
//        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        
//        self.tableViewController.tableView.refreshControl = .refreshControl(didBeginRefreshing: {
//            //
//        })
        
//        self.tableViewController.tableView.refreshControl = .refreshControl(didBeginRefreshing: {
            //
//        })
        
        return result
    }()
    
    lazy var toolBar: UIToolbar = {
        let result = UIToolbar()
        result.items = [
            .init(title: "DemoAdapter", style: .plain, target: self, action: #selector(self.tapDemoAdapter)),
            .init(title: "DemoSectionAdapter", style: .plain, target: self, action: #selector(self.tapDemoSectionAdapter))
        ]
        
        return result
    }()
    
    private var selectedAdapter: Adapter = .demo {
        didSet {
            guard oldValue != self.selectedAdapter else { return }
            self.updateComponents()
        }
    }
    
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
    
//    override func updateComponents() {
//        super.updateComponents()
//
//        switch self.selectedAdapter {
//        case .demo:
//            let adapter = self.createDemoTableAdapter()
////            adapter.output = self
//
//            self.tableViewController.adapter = adapter
//        case .demoSection:
//            let adapter = self.createDemoTableSectionAdapter(number: 0)
////            adapter.output = self
//
//            self.tableViewController.adapter = adapter
//        }
//
//        self.tableViewController.tableView.reloadData()
//    }
    
    @objc
    private func tapDemoAdapter () {
        self.selectedAdapter = .demo
    }
    
    @objc
    private func tapDemoSectionAdapter () {
        self.selectedAdapter = .demoSection
    }
    
    private func createDemoTableSectionAdapter(number: Int) -> DPTableSectionAdapter {
        .init(
            rows: .generateDemoList(count: 10),
            header: .demoTableSectionHeaderModel(title: "Section \(number) start"),
            footer: .demoTableSectionHeaderModel(title: "Section \(number) end")
        )
    }
    
    private func createDemoTableAdapter() -> DPTableAdapter {
        let sections = (1...10).map({ self.createDemoTableSectionAdapter(number: $0) })
        return .init(sections: sections)
    }
    
}

// MARK: - DPTableSectionAdapterOutput
extension DemoTableViewController: DPTableSectionAdapterOutput {
    
    func bottomAchived(_ adapter: DPTableSectionAdapter) {
        print("!!! bottomAchived")
    }
    
    func didSelectRow(_ adapter: DPTableSectionAdapter, at indexPath: IndexPath, model: DPTableRowModel, cell: UITableViewCell) {
        print("[DemoTableViewController] - [didSelectRow] - indexPath:", indexPath)
//        self.tableViewController.tableView.beginRefreshing()
    }
    
}
