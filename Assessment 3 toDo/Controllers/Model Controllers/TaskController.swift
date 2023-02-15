import Foundation

class TaskController {
    
    // MARK: - CRUD Functions
    
    static func createTask(name: String = "New Task", list: List) {
        let newTask = Task(name: name)
        list.tasks.append(newTask)
        
        ListController.shared.save()
    }
    
    static func deleteTask(taskToDelete: Task, from list: List) {
        guard let index = list.tasks.firstIndex(of: taskToDelete) else { return }
        list.tasks.remove(at: index)
        
        ListController.shared.save()
    }
    
    static func toggleComplete(task: Task) {
        task.isChecked.toggle()
        
        ListController.shared.save()
    }
}
