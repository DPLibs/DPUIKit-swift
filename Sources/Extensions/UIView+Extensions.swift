//
//  UIView+Extensions.swift
//  
//
//  Created by Дмитрий Поляков on 11.10.2021.
//

import Foundation
import UIKit

public extension UIView {
    
    // MARK: - Shadow methos
    
    /// Append shadow view aka subview.
    /// - Parameter viewBounds: Required superview bounds.
    /// - Parameter viewRadius: Required superview cornerRadius.
    /// - Parameter shadowColor: Shadow color for layer.
    /// - Parameter shadowOffset: Shadow offset for layer.
    /// - Parameter shadowRadius: Shadow radius for layer.
    /// - Parameter shadowOpacity: Shadow opacity for layer.
    ///
    func appendShadowView(
        viewBounds: CGRect,
        viewRadius: CGFloat,
        shadowColor: UIColor,
        shadowOffset: CGSize,
        shadowRadius: CGFloat,
        shadowOpacity: Float
    ) {
        self.removeShadowView()
        let identifier = "ShadowViewIdentifier"
        
        let shadowView = UIView()
        shadowView.accessibilityIdentifier = identifier
        shadowView.frame = viewBounds
        shadowView.clipsToBounds = false
        self.addSubview(shadowView)

        let layer = CALayer()
        layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: viewRadius).cgPath
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.bounds = shadowView.bounds
        layer.position = shadowView.center
        shadowView.layer.addSublayer(layer)
    }
    
    /// Remove all shadow views from subviews.
    ///
    func removeShadowView() {
        let identifier = "ShadowViewIdentifier"
        
        self.subviews.forEach({
            guard $0.accessibilityIdentifier == identifier else { return }
            
            $0.removeFromSuperview()
        })
    }
    
}
