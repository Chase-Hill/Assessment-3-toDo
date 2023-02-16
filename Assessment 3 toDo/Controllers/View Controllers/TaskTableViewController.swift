import UIKit

class TaskTableViewController: UITableViewController {

    var listReciever: List?
    
    private var filteredTasks: [Task] {
        return listReciever?.tasks ?? []
    }
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Action
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let list = listReciever else { return }
        TaskController.createTask(list: list)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listReciever?.tasks.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)

        // Configure the cell...

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let list = listReciever else { return }
            let task = filteredTasks[indexPath.row]
            TaskController.deleteTask(taskToDelete: task, from: list)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
}
