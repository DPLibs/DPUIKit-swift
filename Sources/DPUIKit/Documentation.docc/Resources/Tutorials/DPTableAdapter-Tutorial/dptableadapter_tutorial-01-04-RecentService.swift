import Foundation

protocol RecentService {
    func getRecents() async -> [Recent]
    func createRecent() async Recent
    func removeRecent(_ recent: Recent) async
}

final class RecentMockService: RecentService {
    
    func getRecents() async -> [Recent] {
        (0...10).map({ _ in Recent.moc() })
    }
    
    func createRecent() async Recent {
        Recent.moc()
    }
    
    func removeRecent(_ recent: Recent) async {
        return
    }
    
}
