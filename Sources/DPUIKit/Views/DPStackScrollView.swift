//
//  DPStackScrollView.swift
//  
//
//  Created by Дмитрий Поляков on 22.10.2021.
//

import Foundation
import UIKit

open class DPStackScrollView: DPView {
    
    // MARK: - Init
    public convenience init(arrangedSubviews: [UIView]) {
        self.init(frame: .zero)
        
        self.updateComponents()
        
        self.removeAllArrangedSubviews()
        self.addArrangedSubviews(arrangedSubviews)
    }
    
    // MARK: - Props
    open lazy var scrollView: UIScrollView = {
        let result = UIScrollView()
        
        return result
    }()
    
    open lazy var stackView: UIStackView = {
        let result = UIStackView()
        
        return result
    }()
    
    open var axis: NSLayoutConstraint.Axis {
        get { self.stackView.axis }
        set {
            self.stackView.axis = newValue
            self.updateComponents()
        }
    }
    
    open lazy var stackWidthConstraint: NSLayoutConstraint = {
        let result = self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
        result.isActive = true
        
        return result
    }()
    
    open lazy var stackHeightConstraint: NSLayoutConstraint = {
        let result = self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
        result.isActive = true
        
        return result
    }()
    
    // MARK: - Methods
    open override func setupComponents() {
        super.setupComponents()
        
        self.scrollView.addToSuperview(self, withConstraints: [ .edges() ])
        self.stackView.addToSuperview(self.scrollView, withConstraints: [ .edges() ])
    }
    
    open override func updateComponents() {
        super.updateComponents()
        
        switch self.axis {
        case .horizontal:
            self.stackWidthConstraint.isActive = false
            self.stackHeightConstraint.isActive = true
        case .vertical:
            self.stackWidthConstraint.isActive = true
            self.stackHeightConstraint.isActive = false
        @unknown default:
            break
        }
    }
    
    @discardableResult
    open func addArrangedSubviews(_ views: [UIView]) -> DPStackScrollView {
        self.stackView.addArrangedSubviews(views)
        
        return self
    }
    
    @discardableResult
    open func removeAllArrangedSubviews() -> DPStackScrollView  {
        self.stackView.removeAllArrangedSubviews()
        
        return self
    }
}
