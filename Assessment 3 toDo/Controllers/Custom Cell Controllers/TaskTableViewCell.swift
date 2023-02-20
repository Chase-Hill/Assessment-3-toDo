import UIKit

protocol TaskTableViewCellDelegate: AnyObject {
    
    func isCheckToggled(cell: TaskTableViewCell)
    
}

class TaskTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var taskNameLabel: UILabel!
    
    @IBOutlet weak var taskCheckButton: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: TaskTableViewCellDelegate?
    
    // MARK: - Funcitons
    
    func updateViews(task: Task) {
        taskNameLabel.text = task.name
        
        let imageName = task.isChecked ? "checkmark.square.fill" : "checkmark.square"
        taskCheckButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    // MARK: - Action
    
    @IBAction func isTaskChecked(_ sender: Any) {
        delegate?.isCheckToggled(cell: self)
    }
}
