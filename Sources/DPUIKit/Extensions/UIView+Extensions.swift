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
    
    // MARK: - Image methods
    
    /// Creates an image based on a view.
    /// - Parameter size: Created image size.
    /// - Parameter fillColor: Created image fill color, default - `UIColor.white`.
    /// - Returns: Created image.
    ///
    func toImage(size: CGSize, fillColor: UIColor = .white) -> UIImage? {
        self.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, self.isOpaque, UIScreen.main.scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(fillColor.cgColor)
        context.fill(CGRect(origin: .zero, size: size))
        self.layer.render(in: context)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img
    }
    
    /// Creates an image based on a view wirh size equal bounds size.
    /// - Parameter fillColor: Created image fill color, default - `UIColor.white`.
    /// - Returns: Created image.
    ///
    func toImageWithBoundsSize(fillColor: UIColor = .white) -> UIImage? {
        self.toImage(size: self.bounds.size, fillColor: fillColor)
    }
    
    // MARK: - Coordinate metods
    
    /// Get absolute coordinates in a superview.
    ///
    func getAbsoluteCoordinateInSuperview() -> CGRect? {
        self.superview?.convert(self.frame, to: nil)
    }
    
    // MARK: - Layouts methods
    
    /// Perform `setNeedsLayout()` and `layoutIfNeeded()`.
    ///
    @discardableResult
    func reloadLayouts() -> UIView {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        return self
    }
    
    // MARK: - Animate methods

    /// Start rotate.
    /// - Parameter duration: Duration value.
    /// - Parameter repeatCount: Repaet value.
    ///
    func startRotationAnimation(duration: TimeInterval = 1, repeatCount: Float = .infinity) {
        let kRotationAnimationKey = "rotation_animation_key"
        
        guard self.layer.animation(forKey: kRotationAnimationKey) == nil else { return }
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float.pi * 2.0
        rotationAnimation.duration = duration
        rotationAnimation.repeatCount = repeatCount

        self.layer.add(rotationAnimation, forKey: kRotationAnimationKey)
    }

    /// Stop rotate.
    ///
    func stopRotationAnimation() {
        let kRotationAnimationKey = "rotation_animation_key"
        
        guard self.layer.animation(forKey: kRotationAnimationKey) != nil else { return }
        self.layer.removeAnimation(forKey: kRotationAnimationKey)
    }
    
    func createStackView(margins directionalLayoutMargins: NSDirectionalEdgeInsets = .zero) -> UIStackView {
        let result = UIStackView(arrangedSubviews: [self])
        result.applyStyles(.directionalLayoutMargins(directionalLayoutMargins))
        
        return result
    }
    
    func createContainerView(insets: NSDirectionalEdgeInsets = .zero) -> UIView {
        let result = UIView()
        self.addToSuperview(result, withConstraints: [ .edgesToSuperview(insets) ])
        
        return result
    }
    
    func removeAllSubviews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
}
