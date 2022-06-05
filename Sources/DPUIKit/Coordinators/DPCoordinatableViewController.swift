//
//  DPCoordinatableViewController.swift
//  
//
//  Created by Дмитрий Поляков on 03.06.2022.
//

import Foundation
import UIKit

public protocol DPCoordinatableViewController: UIViewController {
    
    /// Property to store a strong reference to the `coordinator`
    var coordinator: DPCoordinatorProtocol? { get set }
}
