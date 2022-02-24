//
//  DPSearchBarAdapter.swift
//  
//
//  Created by Дмитрий Поляков on 10.10.2021.
//

import Foundation
import UIKit

open class DPSearchBarAdapter: NSObject, UISearchBarDelegate {
    
    // MARK: - Init
    public init(textMaxLength: Int?, withCancelButton: Bool, delayTextDidChange: TimeInterval = 0.3) {
        self.textMaxLength = textMaxLength
        self.withCancelButton = withCancelButton
        self.delayTextDidChange = delayTextDidChange
        super.init()
    }
    
    // MARK: - Props
    open weak var searchBar: UISearchBar? {
        didSet {
            self.searchBar?.delegate = self
        }
    }
    
    open weak var output: DPSearchBarAdapterOutput?
    open weak var outputUI: DPSearchBarAdapterOutputUI?
    
    public let textMaxLength: Int?
    public let withCancelButton: Bool
    public let delayTextDidChange: TimeInterval
    public let alwaysAllowedCharacters: [String] = ["\n"]
    
    private var timer: Timer?
    
    // MARK: - Methods
    open func provideTextDidChange(value: String?) {
        self.output?.textDidChange(self, value: value, isAfterDelay: false)
        
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: self.delayTextDidChange, repeats: false, block: { [weak self] timer in
            guard let self = self else { return }
            timer.invalidate()
            self.output?.textDidChange(self, value: value, isAfterDelay: true)
        })
    }
    
    private func _setShowsCancelButton(_ isShown: Bool) {
        self.searchBar?.setShowsCancelButton(isShown, animated: true)
        self.outputUI?.showsCancelButton(self, isShown: isShown)
    }
    
    private func _endEditing() {
        self.searchBar?.endEditing(true)
        self.outputUI?.endEditing(self)
    }
    
    // MARK: - UISearchBarDelegate
    open func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard self.withCancelButton else { return }
        self._setShowsCancelButton(true)
    }
    
    open func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self._setShowsCancelButton(false)
    }
    
    open func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self._endEditing()
        self.output?.tapSearchButton(self, value: searchBar.text)
        self.provideTextDidChange(value: searchBar.text)
    }

    open func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.provideTextDidChange(value: searchBar.text)
    }

    open func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self._setShowsCancelButton(false)
        self._endEditing()
        self.output?.tapCancelButton(self)
    }
    
    open func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let textMaxLength = self.textMaxLength, !self.alwaysAllowedCharacters.contains(text)  else { return true }
        
        let count: Int = (searchBar.text as NSString?)?.replacingCharacters(in: range, with: text).count ?? 0
        let maxCountNotAchived = count <= textMaxLength
        self.output?.textMaxLengthAchived(self, textMaxLength: textMaxLength, isAchived: !maxCountNotAchived)
        
        return maxCountNotAchived
    }
    
}
