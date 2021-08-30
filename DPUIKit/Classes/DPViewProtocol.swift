//
//  DPViewProtocol.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 30.08.2021.
//

import Foundation

public protocol DPViewProtocol {
    func setupComponets()
    func updateComponets()
    func setHidden(_ hidden: Bool, animated: Bool)
    func tapButtonAction(_ button: UIButton)
    func tapGestureAction(_ gesture: UITapGestureRecognizer)
}
