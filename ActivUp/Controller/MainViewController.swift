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
    
    @IBOutlet weak var quote: UILabel!
    @IBOutlet weak var ind: UIActivityIndicatorView!
    @IBOutlet weak var welcomeLbl: UILabel!
    let welcomeList = ["Welcome в мир возможностей!",
                       "Это приложение принесет Вам не только знания, но и уверенность в своем будущем.",
                       "Полезный помощник в Вашем путешествии к успеху.",
                       "Если Вы это читаете, то это знак того, что Вас ждут увлекательные и успешные моменты.",
                       "Это приложение принесет вам удовольствие и удовлетворит Ваши ожидания."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLbl.text = welcomeList.randomElement()!
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
        
        ind.startAnimating()
        ind.center = view.center
        loadQuotes()
        loadVideos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !quoteList.isEmpty {
            quote.text = quoteList.randomElement()!
            video.text = videoList.randomElement()!
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
            self.vvv.isHidden = true
            self.ind.stopAnimating()
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
            self.video.text = videoList.randomElement()!
        })
    }
    
}
