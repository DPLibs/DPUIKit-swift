//
//  DPTableDataSourceSectionAdapter.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableDataSourceSectionAdapter: NSObject, UITableViewDataSource {
    
    // MARK: - Props
    open var rows: [DPTableRowModel] = []
    open var header: DPTableSectionHeaderModel?
    open var footer: DPTableSectionHeaderModel?

    // MARK: - UITableViewDataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.rows.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.rows.indices.contains(indexPath.row) else { return .init() }
        let row = self.rows[indexPath.row]
        
        guard
            let cellIdentifier = row.cellIdentifier,
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DPTableViewCell
        else { return .init() }

        cell._model = row
        return cell
    }

}
