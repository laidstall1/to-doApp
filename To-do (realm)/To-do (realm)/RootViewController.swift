import RealmSwift
import UIKit

class RootViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    
    fileprivate var data = [ToDoListItem]()
    
    private let realm = try? Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm!.objects(ToDoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.refresh()
    }

    @IBAction func didTapAddBtn (_ sender: UIButton) {
        guard  let newVC = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {return}
        
        newVC.completion = {[weak self] in
            self?.refresh() }
        
        newVC.title = "New Todo"
        newVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(newVC, animated: true)
    }
    
    func refresh() {
        data = realm!.objects(ToDoListItem.self).map({ $0 })
        table.reloadData()
    }

}
// MARK:- Table Delegates & DataSource
extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row].item
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rowItem = data[indexPath.row]
        guard let detailsVC = storyboard?.instantiateViewController(identifier: "details") as? DetailsViewController else {return}
        
        detailsVC.item = rowItem
        self.refresh()
        
        detailsVC.title = rowItem.item
        detailsVC.navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let deletedRow = data.remove(at: indexPath.row)
            deleteTask(at: deletedRow)
            
            table.reloadData()
        }
    }
}
