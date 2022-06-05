//
//  DPCoordinatableViewController.swift
//  
//
//  Created by Дмитрий Поляков on 03.06.2022.
//

import Foundation
import UIKit

public protocol DPCoordinatableViewController: UIViewController {
    var coordinator: DPCoordinatorProtocol? { get set }
}
