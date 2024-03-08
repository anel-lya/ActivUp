import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

var back : UIColor = .white
var front : UIColor = .black

class MainViewController: UIViewController {

    @IBOutlet weak var vvv: UIView!
    @IBOutlet weak var video: UILabel!
    @IBOutlet weak var book: UILabel!
    
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var ind: UIActivityIndicatorView!
    @IBOutlet weak var welcomeLbl: UILabel!

    @IBOutlet weak var author: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeLbl.text = "Вчера – это история, завтра – это загадка, \nсегодня – это подарок."
        if traitCollection.userInterfaceStyle == .dark {
            back = .black
            front = .white
            print("Темная тема")
        } else {
            back = .white
            front = .black
            print("svet тема")
        }
        view.backgroundColor = back
        vvv.backgroundColor = back
        
        quote.textColor = front
        welcomeLbl.textColor = front
        author.textColor = front
        
        ind.startAnimating()
        ind.center = view.center
        loadQuotes()
        loadVideos()
        loadBooks()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !quoteList.isEmpty {
            quote.text = quoteList.randomElement()!
            video.text = String((videoList.randomElement()!).split(separator: "|")[0])
            book.text = booksList.randomElement()!
        }
      
    }
  
    @IBAction func goVideo(_ sender: Any) {
        let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! TabBarController
        new.modalPresentationStyle = .fullScreen
        new.modalTransitionStyle = .flipHorizontal
        
        new.selectedIndex = 3
        
        self.present(new, animated : true, completion : nil)
    }
    
    @IBAction func goQuote(_ sender: Any) {
        let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! TabBarController
        new.modalPresentationStyle = .fullScreen
        new.modalTransitionStyle = .flipHorizontal
        
        new.selectedIndex = 1
        
        self.present(new, animated : true, completion : nil)
    }
    
    @IBAction func goBook(_ sender: Any) {
        let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! TabBarController
        new.modalPresentationStyle = .fullScreen
        new.modalTransitionStyle = .flipHorizontal
        
        new.selectedIndex = 4
        
        self.present(new, animated : true, completion : nil)
    }
    
    func loadQuotes() {
        Database.database().reference(fromURL: "https://activup-b45a2-default-rtdb.firebaseio.com/quotes").observe(.value, with: {(r) in
            let value = r.value as! [Any]
            quoteList = []
            for elem in value {
                if let e = elem as? String {
                    quoteList.append(e)
                }
            }
            self.quote.text = quoteList.randomElement()!
         
        })
    }
    
    
    func loadVideos() {
        Database.database().reference(fromURL: "https://activup-b45a2-default-rtdb.firebaseio.com/videos").observe(.value, with: {(r) in
            let value = r.value as! [Any]
            videoList = []
            for elem in value {
                if let e = elem as? String {
                    videoList.append(e)
                }
            }
            self.video.text = String((videoList.randomElement()!).split(separator: "|")[0])
        })
    }
    
    func loadBooks() {
        Database.database().reference(fromURL: "https://activup-b45a2-default-rtdb.firebaseio.com/books").observe(.value, with: {(r) in
            let value = r.value as! [Any]
            booksList = []
            for elem in value {
                if let e = elem as? String {
                    booksList.append(e)
                }
            }
            self.book.text = booksList.randomElement()!
            self.vvv.isHidden = true
            self.ind.stopAnimating()
        })
    }
    
}
