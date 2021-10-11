//
//  DPViewProtocol.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 30.08.2021.
//

import Foundation
import UIKit

public protocol DPViewProtocol {
    func setupComponents()
    func updateComponents()
    func setHidden(_ hidden: Bool, animated: Bool)
    func tapButtonAction(_ button: UIButton)
    func tapGestureAction(_ gesture: UITapGestureRecognizer)
}
