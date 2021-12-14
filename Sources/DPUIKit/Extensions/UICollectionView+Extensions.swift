import Foundation
import UIKit

public extension UICollectionView {
    
    // MARK: - Cells methods
    
    /// Registers collectionCells classes in the collectionView.
    /// - Parameter cellClasses - Registered collectionCells classes.
    ///
    func registerCellNibs(_ cellClasses: [AnyClass]) {
        cellClasses.forEach({ cellClass in
            let identifier = NSStringFromClass(cellClass).components(separatedBy: ".").last ?? ""
            let nib = UINib(nibName: identifier, bundle: nil)
            
            self.register(nib, forCellWithReuseIdentifier: identifier)
        })
    }
    
}
