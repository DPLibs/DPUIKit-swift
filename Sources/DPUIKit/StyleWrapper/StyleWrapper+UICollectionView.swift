import Foundation
import UIKit

public extension StyleWrapper where Element: UICollectionView {
    
    static func collectionDefault(_ scrollDirection: UICollectionView.ScrollDirection) -> StyleWrapper {
        return .wrap { collection in
            collection.backgroundColor = .clear
            collection.showsVerticalScrollIndicator = false
            collection.showsHorizontalScrollIndicator = false
            let layout = collection.collectionViewLayout as? UICollectionViewFlowLayout
            layout?.scrollDirection = scrollDirection
            layout?.minimumLineSpacing = .zero
            layout?.minimumInteritemSpacing = .zero
        }
    }
    
    // MARK: - Property
    static func minimumLineSpacing(_ value: CGFloat) -> StyleWrapper {
        return .wrap { collection in
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = value
        }
    }
    
    static func minimumInteritemSpacing(_ value: CGFloat) -> StyleWrapper {
        return .wrap { collection in
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = value
        }
    }
    
    static func spacing(_ value: CGFloat) -> StyleWrapper {
        return .wrap { collection in
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing = value
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = value
        }
    }
    
    static func contentInset(_ value: UIEdgeInsets) -> StyleWrapper {
        return .wrap { collection in
            collection.contentInset = value
        }
    }
    
    static func itemSize(_ value: CGSize) -> StyleWrapper {
        return .wrap { collection in
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = value
        }
    }
    
    static func estimatedItemSize(_ value: CGSize) -> StyleWrapper {
        return .wrap { collection in
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = value
        }
    }
    
    static var itemSizeAutomaticSize: StyleWrapper {
        return .wrap { collection in
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    static var estimatedItemSizeAutomaticSize: StyleWrapper {
        return .wrap { collection in
            (collection.collectionViewLayout as? UICollectionViewFlowLayout)?.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
}
