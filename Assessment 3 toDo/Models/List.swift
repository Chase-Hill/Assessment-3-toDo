import Foundation

class List {
    
    let title: String
    var isChecked: Bool
    let id: UUID
    
    init(title: String, isChecked: Bool = false, id: UUID = UUID()) {
        self.title = title
        self.isChecked = isChecked
        self.id = id
    }
}

extension List: Equatable {
    static func == (lhs: List, rhs: List) -> Bool {
        return lhs.id == rhs.id
    }
}
