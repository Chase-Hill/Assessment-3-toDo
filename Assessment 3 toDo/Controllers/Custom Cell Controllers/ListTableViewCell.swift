import UIKit

protocol ListTableViewCellDelegate: AnyObject {
    
    func isListCheckToggled(cell: ListTableViewCell)

}

class ListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var listNameLabel: UILabel!
    
    @IBOutlet weak var taskNumberLabel: UILabel!
    
    @IBOutlet weak var listCheck: UIButton!
    
    // MARK: - Properties
    
    weak var delegate: ListTableViewCellDelegate?
    
    var list: List? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Helper Functions
    
    func updateViews() {
        guard let list = list else { return }
        listNameLabel.text = list.title
        
        let checkName = list.isChecked ? "checkmark.diamond.fill" : "checkmark.diamond"
        let check = UIImage(systemName: checkName)
        listCheck.setImage(check, for: .normal)
    }
    
    // MARK: - Action
            
    @IBAction func listCheckTapped(_ sender: Any) {
        delegate?.isListCheckToggled(cell: self)
    }
}
