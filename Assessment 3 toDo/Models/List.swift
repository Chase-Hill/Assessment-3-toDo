import Foundation

class List: Codable {
    
    let title: String
    var isChecked: Bool
    let id: UUID
    var tasks: [Task]
    
    init(title: String, isChecked: Bool = false, id: UUID = UUID(), tasks: [Task] = []) {
        self.title = title
        self.isChecked = isChecked
        self.id = id
        self.tasks = tasks
    }
}

// MARK: - Extensions

extension List: Equatable {
    static func == (lhs: List, rhs: List) -> Bool {
        return lhs.id == rhs.id
    }
}
