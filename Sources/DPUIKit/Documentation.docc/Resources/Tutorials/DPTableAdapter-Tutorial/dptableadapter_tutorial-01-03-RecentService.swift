import Foundation

protocol RecentService {
    func getRecents(completion: @escaping ([Recent]) -> Void)
    func createRecent(completion: @escaping (Recent) -> Void)
    func deleteRecent(_ recent: Recent, completion: @escaping () -> Void)
}
