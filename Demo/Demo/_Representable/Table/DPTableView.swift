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
    
    // MARK: - Methods
    open func didSetRefreshControl() {
        guard let refreshControl = self.refreshControl else { return }
        self.bringSubviewToFront(refreshControl)
    }
    
    // MARK: - DPViewProtocol
    open func setupComponents() {
        self.backgroundColor = .white
        self.separatorStyle = .none
        self.keyboardDismissMode = .onDrag

        self.adapter = DPTableAdapter()
    }
    
    open func updateComponents() {}
}
