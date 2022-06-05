//
//  DPCoordinatorProtocol.swift
//  
//
//  Created by Дмитрий Поляков on 03.06.2022.
//

import Foundation

public protocol DPCoordinatorProtocol: AnyObject {
    var didStart: ((DPCoordinatorProtocol?) -> Void)? { get set }
    var didFinish: ((DPCoordinatorProtocol?) -> Void)? { get set }
    
    func start()
    func finish()
}
