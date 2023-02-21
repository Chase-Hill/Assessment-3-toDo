import UIKit

class TaskTableViewController: UITableViewController {

    // MARK: - Properties
    
    var listReciever: List?
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameTextField: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let list = self.listReciever,
              let name = taskNameTextField.text, !name.isEmpty else { return }
        TaskController.createTask(name: name, list: list)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listReciever?.tasks.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell,
              let task = listReciever?.tasks[indexPath.row] else { return UITableViewCell() }
        
        cell.updateViews(task: task)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let list = listReciever else { return }
            let task = list.tasks[indexPath.row]
            TaskController.deleteTask(taskToDelete: task, from: list)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Alert Function
    
    func presentAlert() {
        
        //    What in the world do I want...? I want to present this alert when all checks are checked in my task table view. I need to look at every item in the array. To do that, I need a for-in loop.
        
        let alert = UIAlertController(title: "All Done!", message: "Want us to delete this list?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { [self] _ in
            guard let listReciever = listReciever else { return }
            ListController.shared.deleteList(listToDelete: listReciever)
            navigationController?.popViewController(animated: true)
        })
        
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        present(alert, animated: true)
        
    }
        
    func allChecksTapped() {
        guard var listReciever = listReciever else { return }
        for task in listReciever.tasks {
            if task.isChecked == false {
                return
            }
        }
        presentAlert()
    }
}


// MARK: - Extension

extension TaskTableViewController: TaskTableViewCellDelegate {
    func isCheckToggled(cell: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              let task = listReciever?.tasks[indexPath.row] else { return }
        TaskController.toggleComplete(task: task)
        allChecksTapped()
        cell.updateViews(task: task)
        self.tableView.reloadData()
    }
}
