import Foundation

protocol RecentService {
    func getRecents() async -> [Recent]
    func createRecent() async Recent
    func removeRecent(_ recent: Recent) async
}
