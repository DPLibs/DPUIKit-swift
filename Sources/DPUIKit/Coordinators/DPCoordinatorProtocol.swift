//
//  DPCoordinatorProtocol.swift
//  
//
//  Created by Дмитрий Поляков on 03.06.2022.
//

import Foundation

/// Common coordinator protocol
public protocol DPCoordinatorProtocol: AnyObject {
    
    /// Called at `start`
    var didStart: ((DPCoordinatorProtocol?) -> Void)? { get set }
    
    /// Called at `finish`
    var didFinish: ((DPCoordinatorProtocol?) -> Void)? { get set }
    
    /// Method to start flow
    func start()
    
    /// Method to finish flow
    func finish()
}
