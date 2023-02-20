import UIKit

class ListTableViewController: UITableViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var listNameTextField: UITextField!
    
    // MARK: - LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Action
    
    @IBAction func createListButtonTapped(_ sender: Any) {
        guard let title = listNameTextField.text, !title.isEmpty else { return }
        ListController.shared.createList(title: title)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListController.shared.lists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ListTableViewCell else { return UITableViewCell() }
        
        let listDisplayed = ListController.shared.lists[indexPath.row]
        
        cell.list = listDisplayed
        
        cell.delegate = self
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listToBeDeleted = ListController.shared.lists[indexPath.row]
            ListController.shared.deleteList(listToDelete: listToBeDeleted)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTask" {
            if let indexPath = tableView.indexPathForSelectedRow,
               let destinationVC = segue.destination as? TaskTableViewController {
                let listToSend = ListController.shared.lists[indexPath.row]
                destinationVC.listReciever = listToSend
            }
        }
    }
}

// MARK: - Delegate Extension

extension ListTableViewController: ListTableViewCellDelegate {
    func isListCheckToggled(cell: ListTableViewCell) {
        guard let index = tableView.indexPath(for: cell) else { return }
        let list = ListController.shared.lists[index.row]
        ListController.shared.toggleIsChecked(list: list)
        cell.list = list
    }
}
