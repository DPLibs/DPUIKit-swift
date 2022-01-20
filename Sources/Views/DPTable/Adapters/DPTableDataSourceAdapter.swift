//
//  DPTableDataSourceAdapter.swift
//  
//
//  Created by Дмитрий Поляков on 20.01.2022.
//

import Foundation
import UIKit

open class DPTableDataSourceAdapter: NSObject, UITableViewDataSource {
    
    // MARK: - Props
    open var sections: [DPTableDataSourceSectionAdapter] = []

    // MARK: - UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return 0 }
        return self.sections[section].tableView(tableView, numberOfRowsInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard self.sections.indices.contains(indexPath.section) else { return .init() }
        return self.sections[indexPath.section].tableView(tableView, cellForRowAt: indexPath)
    }

}
