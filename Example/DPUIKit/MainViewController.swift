//
//  MainViewController.swift
//  DPUIKit_Example
//
//  Created by Дмитрий Поляков on 29.08.2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import Foundation
import DPUIKit

// MARK: - Controller - Input
protocol MainViewControllerInput: DPViewControllerInput {}

// MARK: - Model - Input
protocol MainViewModelInput: DPViewModelInput {}

// MARK: - Controller
class MainViewController: DPViewController<MainViewController.ViewModel, DPViewRouter, DPViewErrorHandler>, MainViewControllerInput {
    
    // MARK: - Model
    class ViewModel: DPViewModel, MainViewModelInput {
        
        // MARK: - Props
        let title: String = "MainViewController"
        
        func getTitles(completion: (([String]) -> Void)?) {
            var result: [String] = []
            
            for _ in 0...100 {
                result += [UUID().uuidString]
            }
            
            completion?(result)
        }
    }
    
    // MARK: - Props
    lazy var tableView: DPTableView = {
        let result = DPTableView()
        result.refreshControl = .init()
        result.registerCellClasses([MainListTableRowCell.self])
        result.dataOutput = self
        
        return result
    }()
    
    // MARK: - Methods
    override func loadView() {
        super.loadView()
        
        self.view = self.tableView
    }
    
    override func setupComponets() {
        super.setupComponets()
        
        self.navigationItem.rightBarButtonItems = [
            .init(title: "Add", style: .plain, target: self, action: #selector(self.tapAdd))
        ]
    }
    
    override func updateComponets() {
        super.updateComponets()
        
        guard let model = self.model else { return }
        self.navigationItem.title = model.title
        
        self.reloadData()
    }
    
    override func reloadData() {
        self.model?.getTitles { [weak self] titles in
            let rows = titles.map({ MainListTableRowCell.ViewModel(title: $0) })
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData(with: [.init(rows: rows)])
            }
        }
    }
    
    @objc
    func tapAdd() {
        let row = MainListTableRowCell.ViewModel(title: UUID().uuidString)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.performBatchUpdates(withUpdates: [
                .insertRows([row], at: [.init(row: 0, section: 0)], with: .right)
            ])
        }
    }
    
}

// MARK: - DPTableDataOutput
extension MainViewController: DPTableDataOutput {
    
    func beginRefreshing(_ tableView: DPTableView) {
        self.reloadData()
    }
    
    func selectRow(_ tableView: DPTableView, indexPath: IndexPath, cell: UITableViewCell, row: DPTableRowModel) {
        let row = MainListTableRowCell.ViewModel(title: UUID().uuidString)
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.performBatchUpdates(withUpdates: [
                .reloadRows(newRows: [row], at: [indexPath], with: .fade)
            ])
        }
    }
    
}
