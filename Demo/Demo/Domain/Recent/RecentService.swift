//
//  RecentService.swift
//
//
//  Created by Дмитрий Поляков on 10.10.2023.
//

import Foundation

protocol RecentService {
    func getRecents(completion: @escaping ([Recent]) -> Void)
    func createRecent(completion: @escaping (Recent) -> Void)
    func deleteRecent(_ recent: Recent, completion: @escaping () -> Void)
}

final class RecentMockService: RecentService {
    
    private let outputQueue: DispatchQueue = .main
    
    func getRecents(completion: @escaping ([Recent]) -> Void) {
        self.outputQueue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            let recents = (0...10).map({ _ in Recent.moc() })
            completion(recents)
        }
    }
    
    func createRecent(completion: @escaping (Recent) -> Void) {
        self.outputQueue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            completion(Recent.moc())
        }
    }
    
    func deleteRecent(_ recent: Recent, completion: @escaping () -> Void) {
        self.outputQueue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            completion()
        }
    }
    
    
}
