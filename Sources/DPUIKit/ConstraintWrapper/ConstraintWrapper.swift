//
//  ConstraintWrapper.swift
//  
//
//  Created by Дмитрий Поляков on 08.10.2021.
//

import Foundation
import UIKit

public enum ConstraintWrapper {
    case wrap(constraint: ConstraintVoid)
}

// MARK: - ConstraintWrapper + Store
public extension ConstraintWrapper {
    
    // MARK: - Top
    static func topEqualToSuperview(_ constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
            ])
        }
    }
    
    static func topEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: anchor, constant: constant)
            ])
        }
    }
    
    static func topLessThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            ])
        }
    }
    
    static func topGreaterThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            ])
        }
    }
    
    // MARK: - Bottom
    static func bottomEqualToSuperview(_ constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: constant)
            ])
        }
    }
    
    static func bottomEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(equalTo: anchor, constant: constant)
            ])
        }
    }
    
    static func bottomLessThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            ])
        }
    }
    
    static func bottomGreaterThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            ])
        }
    }
    
    // MARK: - Leading
    static func leadingEqualToSuperview(_ constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant)
            ])
        }
    }
    
    static func leadingEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: anchor, constant: constant)
            ])
        }
    }
    
    static func leadingLessThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            ])
        }
    }
    
    static func leadingGreaterThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, offset: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: offset)
            ])
        }
    }
    
    // MARK: - Trailing
    static func trailingEqualToSuperview(_ constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: constant)
            ])
        }
    }
    
    static func trailingEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(equalTo: anchor, constant: constant)
            ])
        }
    }
    
    static func trailingLessThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            ])
        }
    }
    
    static func trailingGreaterThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            ])
        }
    }
    
    // MARK: - Width
    static func widthEqualToSuperview(_ constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalTo: superview.widthAnchor, constant: constant)
            ])
        }
    }
    
    static func widthEqualToConstant(_ constant: CGFloat) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: constant)
            ])
        }
    }
    
    static func widthLessThanOrEqualToConstant(_ constant: CGFloat) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
            ])
        }
    }
    
    static func widthGreaterThanOrEqualToConstant(_ constant: CGFloat) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
            ])
        }
    }
    
    // MARK: - Height
    static func heightEqualToSuperview(_ constant: CGFloat) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalTo: superview.widthAnchor, constant: constant)
            ])
        }
    }
    
    static func heightEqualToConstant(_ constant: CGFloat) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: constant)
            ])
        }
    }
    
    static func heightGreaterThanOrEqualToConstant(_ constant: CGFloat) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
            ])
        }
    }
    
    // MARK: - Center
    static func centerEqualToSuperview(_ constant: CGPoint = .zero) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant.y),
                view.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant.x)
            ])
        }
    }
    
    // MARK: - Center - X
    static func centerXEqualToSuperview(_ constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: constant)
            ])
        }
    }
    
    static func centerXEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.centerXAnchor.constraint(equalTo: anchor, constant: constant)
            ])
        }
    }
    
    // MARK: - Center - Y
    static func centerYEqualToSuperview(_ constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: constant)
            ])
        }
    }
    
    static func centerYEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.centerYAnchor.constraint(equalTo: anchor, constant: constant)
            ])
        }
    }
    
    // MARK: - Other
    static func edgesToSuperview(_ insets: NSDirectionalEdgeInsets = .zero) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom),
                view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.leading),
                view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.trailing)
            ])
        }
    }
    
    static func edgesToSuperview(_ inset: CGFloat) -> ConstraintWrapper {
        .wrap { view in
            guard let superview = view.superview else { return }
            
            let insets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: -inset, trailing: -inset)
            
            NSLayoutConstraint.activate([
                view.topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: insets.bottom),
                view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.leading),
                view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: insets.trailing)
            ])
        }
    }
    
    static func sizeToConstant(_ size: CGSize) -> ConstraintWrapper {
        .wrap { view in
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: size.width),
                view.heightAnchor.constraint(equalToConstant: size.height)
            ])
        }
    }
    
}
