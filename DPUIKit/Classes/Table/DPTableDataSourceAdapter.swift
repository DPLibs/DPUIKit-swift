import Foundation
import UIKit

open class DPTableDataSourceAdapter: NSObject, UITableViewDataSource {
    
    // MARK: - Props
    open weak var tableView: DPTableView? {
        didSet {
            self.tableView?.dataSource = self
        }
    }
    
    open var sections: [DPTableSectionModel] {
        get {
            self.tableView?.sections ?? []
        }
        set {
            self.tableView?.sections = newValue
        }
    }
    
    // MARK: - UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        self.sections.count
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.sections.indices.contains(section) else { return .zero }
        
        return self.sections[section].rows.count
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let row = self.sections.getRow(at: indexPath),
            let cellIdentifier = row.cellIdentifier,
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? DPTableViewCell
        else { return .init() }

        cell._model = row
        
        if let tableView = self.tableView {
            tableView.cellsOutput?.cellForRow(tableView, indexPath: indexPath, cell: cell)
        }

        return cell
    }
    
}
