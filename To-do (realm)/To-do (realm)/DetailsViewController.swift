import RealmSwift
import UIKit

class DetailsViewController: UIViewController {
    
    private let realm = try? Realm()
    
    public var item: ToDoListItem?
    
    @IBOutlet var detailTextField: UITextField!
    
    override func viewDidLoad() {
        view.backgroundColor = #colorLiteral(red: 0.9441131949, green: 0.9441131949, blue: 0.9441131949, alpha: 1)
        super.viewDidLoad()
        detailTextField.text = item?.item
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(didTapUpdate(category:)))
    }
    
    @objc func didTapUpdate(category: ToDoListItem) {
        guard let text = detailTextField.text else {return}
        guard let item = self.item else {return}
        
        updateTask(task: text, category: item)
        
        navigationController?.popToRootViewController(animated: true)
        
    }
}
