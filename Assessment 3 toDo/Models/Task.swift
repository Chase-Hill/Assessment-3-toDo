import Foundation

class Task: Codable {
    
    let name: String
    var isChecked: Bool
    let id: UUID
    
    init(name: String, isChecked: Bool = false, id: UUID = UUID()) {
        self.name = name
        self.isChecked = isChecked
        self.id = id
    }
}

extension Task: Equatable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
}
