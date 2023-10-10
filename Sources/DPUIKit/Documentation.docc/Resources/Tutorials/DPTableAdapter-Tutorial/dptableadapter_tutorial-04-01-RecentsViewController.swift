import Foundation
import UIKit
import DPUIKit

final class RecentsViewController: DPViewController {
    
    // MARK: - Init
    override init() {
        super.init()
        self.model = .init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: RecentsViewModel? {
        get { self._model as? RecentsViewModel }
        set { self._model = newValue }
    }
    
    private lazy var tableView: DPTableView = {
        let recentAdapter = RecentTableRowCell.Adapter()
        
        let result = DPTableView()
        result.separatorStyle = .singleLine
        return result
    }()
    
    // MARK: - Methods
    override func setupComponents() {
        super.setupComponents()
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Recents"
        
        self.tableView.addToSuperview(self.view, withConstraints: [ .edges(to: .safeArea) ])
    }
    
}
