import Foundation
import UIKit

public extension UITableView {
    
    func registerCellClasses(_ cellClasses: [AnyClass]) {
        cellClasses.forEach({ cellClass in
            let identifier = String.className(of: cellClass)
            self.register(cellClass, forCellReuseIdentifier: identifier)
        })
    }

    func registerCellNibs(_ cellClasses: [AnyClass]) {
        cellClasses.forEach({ cellClass in
            let identifier = String.className(of: cellClass)
            let nib = UINib(nibName: identifier, bundle: nil)

            self.register(nib, forCellReuseIdentifier: identifier)
        })
    }

    func registerHeaderFooterViewClasses(_ viewClasses: [AnyClass]) {
        viewClasses.forEach({ viewClass in
            let identifier = String.className(of: viewClass)

            self.register(viewClass, forHeaderFooterViewReuseIdentifier: identifier)
        })
    }

    func registerHeaderFooterViewNibs(_ viewClasses: [AnyClass]) {
        viewClasses.forEach({ viewClass in
            let identifier = String.className(of: viewClass)
            let nib = UINib(nibName: identifier, bundle: nil)

            self.register(nib, forHeaderFooterViewReuseIdentifier: identifier)
        })
    }
    
    func calculateBottomOffset() -> CGPoint {
        let y =
            self.contentSize.height -
            self.frame.size.height +
            self.contentInset.top +
            self.contentInset.bottom

        return .init(x: 0, y: y)
    }
    
}
