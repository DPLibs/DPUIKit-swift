//
//  DPTableView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableView: UITableView {
    
    // MARK: - Init
    public override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Props
    open override var refreshControl: UIRefreshControl? {
        didSet { self.didSetRefreshControl() }
    }
    
    open override var tableHeaderView: UIView? {
        didSet { self.didSetRefreshControl() }
    }
    
    open var adapter: DPTableAdapter? {
        didSet { self.adapter?.tableView = self }
    }
    
    open var sections: [DPTableSectionProtocol] = []
    
    // MARK: - Methods
    open func didSetRefreshControl() {
        guard let refreshControl = self.refreshControl else { return }
        self.bringSubviewToFront(refreshControl)
    }
    
    open func reloadData(_ sections: [DPTableSectionProtocol]) {
        self.sections = sections
        self.reloadData()
    }
    
    // MARK: - DPViewProtocol
    open func setupComponents() {
        self.adapter = .init()
    }
    
    open func updateComponents() {}
}
