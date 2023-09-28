//
//  DPViewModelOutput.swift
//  
//
//  Created by Дмитрий Поляков on 02.02.2022.
//

import Foundation

/// Interface for sending notifications from ``DPViewModel``.
///
/// Part of <doc:MVVM>. 
public protocol DPViewModelOutput: AnyObject {
    
    /// Reports that an error has been received
    func modelDidError(_ model: DPViewModel?, error: Error)
    
    /// Data reload has started
    func modelBeginReloading(_ model: DPViewModel?)
    
    /// Data loading has started
    func modelBeginLoading(_ model: DPViewModel?)
    
    /// Data loading has finished. Possibly with an error
    func modelFinishLoading(_ model: DPViewModel?, withError error: Error?)
    
    /// Data updated
    func modelUpdated(_ model: DPViewModel?)
    
    /// Data reloaded
    func modelReloaded(_ model: DPViewModel?)
}
