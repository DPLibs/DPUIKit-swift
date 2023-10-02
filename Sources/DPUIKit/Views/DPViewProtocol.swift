//
//  DPViewProtocol.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 30.08.2021.
//

import Foundation
import UIKit

/// The library provides several custom views (`DPView`, `DPControl`, `DPSwitch` and others). They all implement a common protocol `DPViewProtocol`.
public protocol DPViewProtocol {
    
    /// Method for initial configuration of components.
    /// Here you can customize basic constraints, colors, and more.
    /// Called by default during initialization.
    func setupComponents()
    
    /// Method for updating components.
    /// It should be called when the view model changes, or the state changes.
    func updateComponents()
}
