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
    
    // MARK: - Props
    lazy var tableViewController: DPTableViewController = {
        let result = DPTableViewController()
        result.tableView.registerHeaderFooterViewClasses([HeaderTableView.self])
        result.tableView.refreshControl = .refreshControl(didBeginRefreshing: { [weak self] in
            print("!!! didBeginRefreshing")
        })
//        result.tableView.registerCellClasses([RandomTitleTableRowCell.self])
        
        return result
    }()
//    lazy var pageViewController: DPPageContainerViewController = {
//        let result = DPPageContainerViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
//        result.delegate = self
//        
//        return result
//    }()
    
//    lazy var showPreviousBarButtonItem: UIBarButtonItem = {
//        UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(self.tapShowPrevious))
//    }()
//
//    lazy var showNextBarButtonItem: UIBarButtonItem = {
//        UIBarButtonItem(title: ">", style: .plain, target: self, action: #selector(self.tapShowNext))
//    }()
    
    lazy var toolBar: UIToolbar = {
        let result = UIToolbar()
//        result.items = [
//            self.showPreviousBarButtonItem,
//            .init(title: "Add to start", style: .plain, target: self, action: #selector(self.tapAddToStart)),
//            .init(title: "Remove last", style: .plain, target: self, action: #selector(self.tapRemoveLast)),
//            self.showNextBarButtonItem
//        ]
        
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
        
        let adapter = DPTableSectionAdapter.randomAdapter()
        adapter.output = self
        
        self.tableViewController.adapter = adapter
        
        
//        self.setPages(numbers: Array(0...9))
//        self.updateArrows()
    }
    
//    private func setPages(numbers: [Int]) {
//        let pages: [UIViewController] =  numbers.map({ number in
//            let page = UIViewController()
//            page.view.backgroundColor = .white
//
//            let label = UILabel()
//            label.font = .systemFont(ofSize: 32)
//            label.text = "Page \(number + 1)"
//
//            label.addToSuperview(page.view, withConstraints: [ .centerEqualToSuperview() ])
//
//            return page
//        })
//
//        self.pageViewController.setPages(pages, animated: true)
//    }
    
//    @objc
//    private func tapShowPrevious () {
//        self.pageViewController.showPage(direction: .reverse, animated: true)
//    }
//
//    @objc
//    private func tapAddToStart() {
//        let indexSelected = self.pageViewController.pageSelectedIndex
//        let numbers = ([-1] + Array(self.pageViewController.pages.indices)).map({ $0 + 1 })
//        self.setPages(numbers: numbers)
//
//        guard let index = indexSelected else { return }
//        self.pageViewController.showPage(at: index + 1, animated: false)
//    }
//
//    @objc
//    private func tapRemoveLast() {
//        self.pageViewController.pages =  Array(self.pageViewController.pages.dropLast())
//    }
//
//    @objc
//    private func tapShowNext () {
//        self.pageViewController.showPage(direction: .forward, animated: true)
//    }
//
//    private func updateArrows() {
//        self.showPreviousBarButtonItem.isEnabled = self.pageViewController.pageIsAvalible(forDirection: .reverse)
//        self.showNextBarButtonItem.isEnabled = self.pageViewController.pageIsAvalible(forDirection: .forward)
//    }
    
}

// MARK: - DPTableSectionAdapterOutput
extension DemoTableViewController: DPTableSectionAdapterOutput {
    
    func didSelectRow(_ adapter: DPTableSectionAdapter, at indexPath: IndexPath, model: DPTableRowModel, cell: UITableViewCell) {
        print("[DemoTableViewController] - [didSelectRow] - indexPath:", indexPath)
        self.tableViewController.tableView.beginRefreshing()
    }
    
}

private class RandomTitleTableRowCell: DPTableRowCell<RandomTitleTableRowCell.Model> {
    
    class Model: DPTableRowModel {
        
        init() {
            self.title = UUID().uuidString
        }
        
//        override var cellIdentifier: String? {
//            print("!!! cellIdentifier", RandomTitleTableRowCell.className)
//            return RandomTitleTableRowCell.className
//        }
        
        override var cellClass: AnyClass? {
            RandomTitleTableRowCell.self
        }
        
        let title: String
    }
    
    lazy var label: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        result.textColor = .black
        
        return result
    }()
    
    override func setupComponents() {
        super.setupComponents()
        
        self.label.addToSuperview(self.contentView, withConstraints: [
            .edgesToSuperview(insetsOffset: 16)
        ])
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.label.text = self.model?.title
    }
    
}
 
private extension DPTableRowModel {
    
    static func randomTitleTableRow() -> RandomTitleTableRowCell.Model {
        .init()
    }
    
}

private extension DPTableSectionAdapter {
    
    static func randomAdapter() -> DPTableSectionAdapter {
        .init(
            rows: [.randomTitleTableRow(), .randomTitleTableRow(), .randomTitleTableRow(), .randomTitleTableRow()],
            header: HeaderTableView.Model(title: "Section 1")
        )
    }
    
}

private class HeaderTableView: DPTableSectionHeaderView<HeaderTableView.Model> {
     
    class Model: DPTableSectionHeaderModel {
        
        override var viewIdentifier: String? {
            "HeaderTableView"
        }
        
        override var viewHeight: CGFloat {
            100
        }
        
        init(title: String) {
            self.title = title
        }
        
        let title: String
        
    }
    
    lazy var label: UILabel = {
        let result = UILabel()
        result.numberOfLines = 0
        result.textColor = .red
        
        return result
    }()
    
    override func setupComponents() {
        super.setupComponents()
        
        self.backgroundColor = .gray
        self.contentView.backgroundColor = .yellow
        
        self.label.addToSuperview(self.contentView, withConstraints: [
            .edgesToSuperview(insetsOffset: 16)
        ])
        
        self.contentView.applyConstraints(.heightEqualToConstant(100))
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        self.label.text = self.model?.title
    }
    
}

private extension DPTableAdapter {
    
    static func randomAdapter() -> DPTableAdapter {
        .init(sections: [
            .randomAdapter(),
            .randomAdapter(),
            .randomAdapter(),
            .randomAdapter(),
            .randomAdapter()
        ])
    }
    
}
