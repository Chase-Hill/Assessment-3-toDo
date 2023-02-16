import Foundation

class Task: Codable { //Note: Codable allows us to encode and decode the data through our save and load persistence functions.
    
    let name: String
    var isChecked: Bool
    let id: UUID
    
    init(name: String, isChecked: Bool = false, id: UUID = UUID()) {
        self.name = name
        self.isChecked = isChecked
        self.id = id
    }
}

extension Task: Equatable { //Note: Equatable allows us to ensure that we are deleting the correct row in our table view.
    static func == (lhs: Task, rhs: Task) -> Bool {
        lhs.id == rhs.id
    }
}
