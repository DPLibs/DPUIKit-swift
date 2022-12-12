//
//  DPLayoutGuide.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.10.2022.
//

import Foundation
import UIKit

public protocol DPLayoutGuide {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var leftAnchor: NSLayoutXAxisAnchor { get }
    var rightAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

// MARK: - UIView + DPConstraintLayout
extension UIView: DPLayoutGuide {}

// MARK: - UILayoutGuide + DPConstraintLayout
extension UILayoutGuide: DPLayoutGuide {}
