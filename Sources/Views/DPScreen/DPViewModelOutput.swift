//
//  DPViewModelOutput.swift
//  
//
//  Created by Дмитрий Поляков on 02.02.2022.
//

import Foundation

public protocol DPViewModelOutput: AnyObject {
    func didError(_ model: DPViewModel?, _ error: Error)
    func didBeginLoading(_ model: DPViewModel?)
    func didFinishLoading(_ model: DPViewModel?, error: Error?)
    func didUpdate(_ model: DPViewModel?)
    func didReload(_ model: DPViewModel?)
}
