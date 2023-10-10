import Foundation
import DPUIKit

final class RecentsViewModel: DPViewModel {
    
    // MARK: - Init
    override init() {
        self.recentService = RecentMockService()
    }
    
    // MARK: - Props
    private let recentService: RecentService
    private(set) var recents: [Recent] = []
    
    var onRecents: (([Recent]) -> Void)?
    var onCreateRecent: ((Recent) -> Void)?
    var onDeleteRecent: ((Recent) -> Void)?
}
