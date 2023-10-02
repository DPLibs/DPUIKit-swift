//
//  DPTableView.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

/// Custom component [UITableView](https://developer.apple.com/documentation/uikit/uitableview).
open class DPTableView: UITableView, DPViewProtocol {
    
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
        didSet { self.bringRefreshControlToFront() }
    }
    
    open override var tableHeaderView: UIView? {
        didSet { self.bringRefreshControlToFront() }
    }
    
    /// Property for storing a strong reference to ``DPTableAdapter``.
    open var adapter: DPTableAdapter? {
        didSet { self.adapter?.tableView = self }
    }
    
    // MARK: - Methods
    open func bringRefreshControlToFront() {
        guard let refreshControl = self.refreshControl else { return }
        self.bringSubviewToFront(refreshControl)
    }
    
    // MARK: - DPViewProtocol
    open func setupComponents() {
        self.backgroundColor = .white
        self.separatorStyle = .none
        self.keyboardDismissMode = .onDrag
    }
    
    open func updateComponents() {}
}
