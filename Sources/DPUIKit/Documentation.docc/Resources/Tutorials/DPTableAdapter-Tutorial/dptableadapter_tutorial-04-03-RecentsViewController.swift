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
    
    var didSelect: ((Recent) -> Void)?
    
    private lazy var tableView: DPTableView = {
        let recentAdapter = RecentTableRowCell.Adapter(
            didSelect: { [weak self] ctx in
                self?.didSelect?(ctx.model)
            },
            onCellLeading: { [weak self] ctx in
                .init(actions: [
                    .init(style: .normal, title: "Info", handler: { [weak self] _, _, handler in
                        handler(true)
                        self?.showInfo(ctx.model)
                    })
                ])
            }
        )
        
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

// MARK: - Private
private extension RecentsViewController {
    
    func showInfo(_ recent: Recent) {
        let alert = UIAlertController(title: "Info", message: "This is info of Recent", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
}
