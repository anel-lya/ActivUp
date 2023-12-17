import UIKit

class LovedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var table: UITableView!
    var c = 0
    var lovedList : [Lodev] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100.0
        
        
        view.backgroundColor = back
        table.backgroundView?.backgroundColor = back
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadTasks()
    }
    
    
    func reloadTasks() {
        lovedList = LovedDataManager.shared.fetchLodevStr()
        table.reloadData()
    }
   
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lovedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "love") as! LovedTableViewCell
        cell.title.text = lovedList[indexPath.row].quote
       
        if c == 0 {
            cell.title.textAlignment = .left
            c = 1
        }
        else {
            cell.title.textAlignment = .right
            c = 0
        }
        cell.title.textColor = front
            cell.v.backgroundColor = back
       
        cell.v.frame.size.height = cell.frame.size.height - 10
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let len = Double((lovedList[indexPath.row].quote)!.count)
        
        return ceil(len/39) * 50
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let doneAction = UIContextualAction(style: .normal, title: "удалить") { (action, view, completion) in
            let alert = UIAlertController(title: "Можешь удалить цитату", message: "если захочешь...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "не хочу", style: .cancel))
            alert.addAction(UIAlertAction(title: "хочу", style: .destructive, handler: { action in
                LovedDataManager.shared.deleteNote(n: self.lovedList[indexPath.row])
                self.reloadTasks()
            }))
            self.present(alert, animated: false)
            completion(true)
        }
        doneAction.backgroundColor = UIColor.systemRed
        tableView.deselectRow(at: indexPath, animated: true)

        return UISwipeActionsConfiguration(actions: [doneAction])
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }

}
