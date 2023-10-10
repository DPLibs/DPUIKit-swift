import Foundation

protocol RecentService {
    func getRecents() async -> [Recent]
    func createRecent() async Recent
    func removeRecent(_ recent: Recent) async
}

final class RecentMockService: RecentService {
    
    private let outputQueue: DispatchQueue = .main
    
    private func mockRecent() -> Recent {
        let id = UUID()
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In consectetur quis sem eget placerat. Nunc nisi dolor, malesuada in velit ut, vehicula commodo dui. Fusce fringilla ante non molestie maximus. Aliquam luctus faucibus diam, nec dapibus nunc. Ut non aliquet purus. Donec pellentesque nisl a ligula lobortis, a consectetur leo gravida. Morbi sed sodales mauris. Sed sed ipsum tristique, vulputate sem non, cursus leo. fringilla."
        
        return Recent(
            id: id,
            title: "# \(id.uuidString)",
            body: String(text.prefix(.random(in: 10...text.count)))
        )
    }
    
    func getRecents(completion: @escaping ([Recent]) -> Void) {
        let recents = (0...10).map({ _ in self.mockRecent() })
        
        self.outputQueue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            completion(recents)
        }
    }
    
    func createRecent(completion: @escaping (Recent) -> Void) {
        let recent = self.mockRecent()
        
        self.outputQueue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            completion(recent)
        }
    }
    
    func deleteRecent(_ recent: Recent, completion: @escaping () -> Void) {
        self.outputQueue.asyncAfter(deadline: .now() + .milliseconds(500)) {
            completion()
        }
    }
    
    
}
