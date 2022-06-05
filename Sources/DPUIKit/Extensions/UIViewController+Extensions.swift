import Foundation
import UIKit

public extension UIViewController {

    // MARK: - Keyboard methods
    
    /// The method ends editing (hides the keyboard) when tapping on the view.
    ///
    func endEditingOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.didHideKeyboardOnTap))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    /// Handler for `endEditingOnTap()` tapGestureRecognizer .
    ///
    @objc
    private func didHideKeyboardOnTap() {
        self.view.endEditing(true)
    }
    
    // MARK: - Child methods
    func addAsChildToParent(_ parent: UIViewController) {
        parent.addChild(self)
        self.didMove(toParent: parent)
        self.willMove(toParent: parent)
    }
    
    func removeAsChildFromParent() {
        self.removeFromParent()
        self.willMove(toParent: nil)
        self.didMove(toParent: nil)
    }
    
}
