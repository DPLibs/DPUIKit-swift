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
    func setupComponents()
    func updateComponents()
    func setHidden(_ hidden: Bool, animated: Bool)
}
