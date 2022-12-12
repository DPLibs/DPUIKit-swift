//
//  DPEdgesConstraint.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.10.2022.
//

import Foundation
import UIKit

public final class DPEdgesConstraint: DPConstraint {
    
    // MARK: - Init
    init(
        topConstraint: NSLayoutConstraint,
        leadingConstraint: NSLayoutConstraint,
        bottomConstraint: NSLayoutConstraint,
        trailingConstraint: NSLayoutConstraint
    ) {
        self.topConstraint = topConstraint
        self.leadingConstraint = leadingConstraint
        self.bottomConstraint = bottomConstraint
        self.trailingConstraint = trailingConstraint
    }
    
    public init(
        _ view: UIView,
        to layout: DPLayoutGuide,
        insets: NSDirectionalEdgeInsets = .zero
    ) {
        self.topConstraint = view.topAnchor.constraint(equalTo: layout.topAnchor, constant: insets.top)
        self.leadingConstraint = view.leadingAnchor.constraint(equalTo: layout.leadingAnchor, constant: insets.leading)
        self.bottomConstraint = view.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: insets.bottom)
        self.trailingConstraint = view.trailingAnchor.constraint(equalTo: layout.trailingAnchor, constant: insets.trailing)
    }
    
    // MARK: - Props
    public let topConstraint: NSLayoutConstraint
    public let leadingConstraint: NSLayoutConstraint
    public let bottomConstraint: NSLayoutConstraint
    public let trailingConstraint: NSLayoutConstraint
    
    public var isActive: Bool {
        get {
            [
                self.topConstraint,
                self.leadingConstraint,
                self.trailingConstraint,
                self.bottomConstraint
            ].allSatisfy({ $0.isActive })
        }
        set {
            [
                self.topConstraint,
                self.leadingConstraint,
                self.trailingConstraint,
                self.bottomConstraint
            ].forEach({ $0.isActive = newValue })
        }
    }
    
    public var insets: NSDirectionalEdgeInsets {
        get {
            NSDirectionalEdgeInsets(
                top: self.topConstraint.constant,
                leading: self.leadingConstraint.constant,
                bottom: self.bottomConstraint.constant,
                trailing: self.trailingConstraint.constant
            )
        }
        set {
            self.topConstraint.constant = newValue.top
            self.leadingConstraint.constant = newValue.leading
            self.bottomConstraint.constant = newValue.bottom
            self.trailingConstraint.constant = newValue.trailing
        }
    }
    
}
