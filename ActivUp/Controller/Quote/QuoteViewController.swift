import UIKit


class QuoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var lblb: UILabel!
    @IBOutlet weak var tb: UITabBarItem!
    var c = 0
    @IBOutlet weak var ind: UIActivityIndicatorView!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ind.startAnimating()
        ind.center = view.center

        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100.0 
        
        view.backgroundColor = back
        table.backgroundView?.backgroundColor = back
        

        lblb.text = ""
        lblb.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        lblb.addGestureRecognizer(tapGesture)

    }

    override func viewDidAppear(_ animated: Bool) {
        quoteList.shuffle()
        lblb.text = ""
        self.ind.stopAnimating()
        self.table.reloadData()
    }
    
    @objc func labelTapped() {
            
        if !lblb.text!.isEmpty {
            let a = UIAlertController(title: "Понравилась цитата?", message: "Сохрани ее себе в избранные", preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "да, давайте", style: .cancel, handler: {_ in
                let l = self.lblb.text!
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
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quoteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! QuoteTableViewCell
        cell.title.text = (quoteList[indexPath.row])
       
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
        
        cell.v.frame.size.height = cell.frame.size.height - 15
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        lblb.text = quoteList[indexPath.row]
        table.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let len = Double((quoteList[indexPath.row]).count)
        return ceil(len/39) * 50
        
    }

}
