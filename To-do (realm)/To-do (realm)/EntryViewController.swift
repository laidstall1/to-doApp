import RealmSwift
import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!

    private let realm = try? Realm()
    
    public var completion: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9441131949, green: 0.9441131949, blue: 0.9441131949, alpha: 1)
        textField.becomeFirstResponder()
        textField.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func didTapSave() {
        if let text = textField.text, !text.isEmpty {
            let newItem = ToDoListItem()
            
            saveTask(task: text, category: newItem)
            
            completion?()
            navigationController?.popToRootViewController(animated: true)

        } else {
            let alert = UIAlertController(title: "Empty Todo", message: "Please Add To-do", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true)
        }
    }
}
