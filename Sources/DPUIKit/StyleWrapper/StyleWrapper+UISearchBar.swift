import Foundation
import UIKit

public extension StyleWrapper where Element: UISearchBar {
    
    static var searchBarDefault: StyleWrapper {
        return .wrap { searchBar in
            searchBar.backgroundImage = UIImage()
            searchBar.barTintColor = .clear
            searchBar.backgroundColor = .gray
            searchBar.tintColor = .systemBlue
            searchBar.placeholder = NSLocalizedString("Search", comment: "")
            searchBar.showsBookmarkButton = false
            searchBar.searchBarStyle = .default
            guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
            textField.backgroundColor = .lightGray
            textField.textColor = .black
        }
    }
    
    static func placeholder(_ value: String) -> StyleWrapper {
        return .wrap { searchBar in
            searchBar.placeholder = value
        }
    }
    
    static func backgroundImage(_ value: UIImage) -> StyleWrapper {
        return .wrap { searchBar in
            searchBar.backgroundImage = value
        }
    }
    
    static func backgroundColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { searchBar in
            searchBar.backgroundColor = value
        }
    }
    
    static func innerBackgroundColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { searchBar in
            guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
            textField.backgroundColor = value
        }
    }
    
    static func tintColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { searchBar in
            searchBar.tintColor = value
        }
    }
    
    static func textColor(_ value: UIColor) -> StyleWrapper {
        return .wrap { searchBar in
            guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
            textField.textColor = value
        }
    }
    
    static func setImage(_ value: UIImage?, place: UISearchBar.Icon, state: UIControl.State = .normal) -> StyleWrapper {
        return .wrap { searchBar in
            searchBar.setImage(value, for: place, state: state)
        }
    }
    
    static func rightView(_ view: UIView?, mode: UITextField.ViewMode) -> StyleWrapper {
        return .wrap { searchBar in
            guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
            textField.rightView = view
            textField.rightViewMode = mode
        }
    }
    
    static func leftView(_ view: UIView?, mode: UITextField.ViewMode) -> StyleWrapper {
        return .wrap { searchBar in
            guard let textField = searchBar.value(forKey: "searchField") as? UITextField else { return }
            textField.leftView = view
            textField.leftViewMode = mode
        }
    }
    
}
