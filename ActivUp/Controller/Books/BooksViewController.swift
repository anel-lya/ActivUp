import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableBook: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableBook.dataSource = self
        tableBook.delegate = self

        tableBook.rowHeight = UITableView.automaticDimension
        tableBook.estimatedRowHeight = 100.0
        
        view.backgroundColor = back
        tableBook.backgroundView?.backgroundColor = back
        
    }
    override func viewDidAppear(_ animated: Bool) {
        booksList.shuffle()
        self.tableBook.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let len = Double((booksList[indexPath.row]).count)
        return ceil(len/39) * 50
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "books") as! BooksTableViewCell
        let elem = (booksList[indexPath.row]).split(separator: "|")
        cell.lblBook.text = String(elem[0])
        cell.lblAu.text = String(elem[1])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let a = UIAlertController(title: "Понравилась цитата?", message: "Сохрани ее себе в избранные", preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "да, давайте", style: .cancel, handler: {_ in
            let elem = (booksList[indexPath.row]).split(separator: "|")
            let l = String(elem[0])
            let ll = LovedDataManager.shared.fetchLodevStr()
            var isExist = false
            for i in ll {
                if i.quote == l{
                    isExist = true
                }
            }
            if (!isExist){
                LovedDataManager.shared.saveLodev(q: l)
            }
        }))
        a.addAction(UIAlertAction(title: "в другой раз", style: .destructive))
        self.present(a, animated: true)
        tableBook.deselectRow(at: indexPath, animated: true)
    }

}
