//
//  TestViewController.swift
//  Demo
//
//  Created by Дмитрий Поляков on 09.09.2023.
//

import Foundation
import UIKit
import DPUIKit

class TestViewController: DPViewController {
    
    private lazy var tableView = TableView()
    
    override func loadView() {
        self.view = self.tableView
    }
    
}

public struct TableConstants {
    public static let cellHeight: CGFloat = UITableView.automaticDimension
    public static let cellEstimatedHeight: CGFloat = 50
    public static let headerFooterHeight: CGFloat = UITableView.automaticDimension
    public static let headerFooterEstimatedHeight: CGFloat = 32
}
