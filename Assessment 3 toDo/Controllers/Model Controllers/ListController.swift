import Foundation

class ListController {
    
    // MARK: - Properties
    
    ///Shared Instance
    
    static let shared = ListController()
    
    ///Source of Truth
    
    var lists: [List] = []
    
    // MARK: - Initializers
    
    init() {
        
        load()
        
    }
    
    // MARK: - CRUD Functions
    
    func createList(name: String = "Untitled List", tasks: [Task] = []) {
        let list = List(title: name, tasks: tasks)
        lists.append(list)
        
        save()
        
    }
    
    func toggleIsChecked(list: List) {
        list.isChecked.toggle()
        
        save()
    }
    
    func deleteList(listToDelete: List) {
        guard let index = lists.firstIndex(of: listToDelete) else { return }
        lists.remove(at: index)
        
        save()
        
    }
    
    // MARK: - Persistence
    
    private var fileURL: URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let finalURL = documentsDirectory.appendingPathComponent("lists.json")
        return finalURL
    }
    
    func save() {
        // 1: Get the address to save the file to
        guard let saveLocation = fileURL else { return }
        // 2: Convert the Swift struct or class inot JSON Data
        do {
            let jsonData = try JSONEncoder().encode(lists)
            // 3: save (write) the data to the address from step 1
            try jsonData.write(to: saveLocation)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func load() {
        // 1. Get the address the data is saved at
        guard let url = fileURL else {return}
        // 2. Load that JSON data from the address
        do {
            let retrievedJSONData = try Data(contentsOf: url)
            // 3. Convert from JSON to our Swift Model Object Type
            let decodedLists = try JSONDecoder().decode([List].self, from: retrievedJSONData)
            self.lists = decodedLists
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
