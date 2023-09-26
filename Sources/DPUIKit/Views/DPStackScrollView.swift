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
    open var scrollView = UIScrollView()
    open var stackView = UIStackView()
    
    open var axis: NSLayoutConstraint.Axis {
        get { self.stackView.axis }
        set {
            self.stackView.axis = newValue
            self.updateComponents()
        }
    }
    
    open lazy var stackWidthConstraint: NSLayoutConstraint = self.stackView.widthAnchor.constraint(equalTo: self.widthAnchor)
    open lazy var stackHeightConstraint: NSLayoutConstraint = self.stackView.heightAnchor.constraint(equalTo: self.heightAnchor)
    
    // MARK: - Methods
    open override func setupComponents() {
        super.setupComponents()
        
        self.scrollView.addToSuperview(self, withConstraints: [ .edges() ])
        self.stackView.addToSuperview(self.scrollView, withConstraints: [ .edges() ])
        
        self.updateComponents()
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
    
    @discardableResult
    open func setArrangedSubviews(_ views: [UIView]) -> DPStackScrollView  {
        self.stackView.setArrangedSubviews(views)
        return self
    }
}
