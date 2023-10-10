import Foundation

struct Recent: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let body: String
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
