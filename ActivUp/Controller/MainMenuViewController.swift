
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase
import FirebaseAuth

var back : UIColor = .white
var front : UIColor = .black

class MainMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    @IBOutlet weak var lblwel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var ind: UIActivityIndicatorView!
    
    let welcomeList = ["Welcome в мир возможностей!",
                       "Это приложение принесет Вам не только знания, но и уверенность в своем будущем.",
                       "Полезный помощник в Вашем путешествии к успеху.",
                       "Если Вы это читаете, то это знак того, что Вас ждут увлекательные и успешные моменты.",
                       "Это приложение принесет вам удовольствие и удовлетворит Ваши ожидания."]
    override func viewDidLoad() {
        lblwel.text = welcomeList.randomElement()!
        
        //LovedDataManager.shared.deleteAllData()
        
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
        table.backgroundView?.backgroundColor = back
        
        super.viewDidLoad()
        ind.startAnimating()
        ind.center = view.center
        loadQuotes()
        loadVideos()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainMenu") as! MainMenuTableViewCell
        cell.isUserInteractionEnabled = true

        let elem = mainList[indexPath.row]
        if indexPath.row == 0 {
            cell.perehodlbl.text = "перейти к видео..."
            cell.mainlbl.text = (elem?.randomElement()!)?.replacingOccurrences(of: "/", with: " - ")
        }
        else {
            cell.perehodlbl.text = "перейти к цитатам..."
            cell.mainlbl.text = elem?.randomElement()!
        }
        
        
        cell.mainlbl.textColor = front
        
//        if indexPath.row == 0 {
//            let elem = elem as! [Video]
//            let img = UIImage(named: elem[0].img)
//            let imgV = UIImageView(image: img)
//            imgV.frame.size.width = 100
//            imgV.frame.size.height = 100
//            
//            let lbl = UILabel()
//            //print(elem[0].chanel)
//            lbl.text = elem[0].chanel
//            lbl.font = UIFont.systemFont(ofSize: 16.0)
//            
//            lbl.numberOfLines = 0
//            
//            lbl.layer.borderColor = UIColor.red.cgColor
//            lbl.layer.borderWidth = 1.0
//            
//            let horizontalStackView = UIStackView(arrangedSubviews: [imgV, lbl])
//            horizontalStackView.axis = .horizontal
//            horizontalStackView.spacing = 10
//            horizontalStackView.frame = CGRect(x: 0, y: 0, width: 200, height: 125)
//            
//            cell.firstView.addSubview(horizontalStackView)
//            
//            let img2 = UIImage(named: elem[1].img)
//            let imgV2 = UIImageView(image: img2)
//            imgV2.frame.size.width = 100
//            imgV2.frame.size.height = 100
//            cell.secView.addSubview(imgV2)
//        }
//        else {
//            for subview in cell.secView.subviews {
//                subview.removeFromSuperview()
//            }
//            for subview in cell.firstView.subviews {
//                subview.removeFromSuperview()
//            }
//
//
//            let elem = elem as! [[String]]
//            
//            let label = UILabel()
//            label.text = elem[0][Int.random(in: 0..<quoteList.count)]
//            label.textColor = UIColor.black
//            label.font = UIFont.systemFont(ofSize: 16.0)
//            label.textAlignment = .center
//            label.numberOfLines = 3
//            label.layer.borderColor = UIColor.purple.cgColor
//            label.layer.borderWidth = 1.0
//            label.frame = CGRect(x: 0, y: 0, width: 200, height: 125)
//            cell.firstView.addSubview(label)
//            
//            let label1 = UILabel()
//            label1.text = elem[0][Int.random(in: 0..<quoteList.count)]
//            label1.textColor = UIColor.black
//            label1.font = UIFont.systemFont(ofSize: 16.0)
//            label1.textAlignment = .center
//            label1.numberOfLines = 3
//            label1.layer.borderColor = UIColor.purple.cgColor
//            label1.layer.borderWidth = 1.0
//            label1.frame = CGRect(x: 0, y: 0, width: 200, height: 125)
//            cell.secView.addSubview(label1)
//
//        }
//        
        
        return cell
    }
    
//    
//    @objc func labelTapped() {
//        print(1)
//    }
//var mainDictionary = ["question?" : ["answer1" : 1, "answer2" : 1, "answer3" : 0]]
//
//    // Обновленный метод с параметром sender
//    @objc func buttonTapped(_ sender: MainMenuTableViewCell) {
//        print(sender.firstView)
////        if let title = sender.currentTitle,
////           let selectedAnswer = mainDictionary["question?"]?[title] {
//            handleButtonTapped(number: 3)
//        //}
//    }
//
//    func handleButtonTapped(number: Int) {
//        print("Переданное число: \(number)")
//        // Здесь вы можете выполнять дополнительные действия с переданным числом
//    }
//    
//    не работает нажатие на элемент в табличке
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hello")
        
        let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! TabBarController
        new.modalPresentationStyle = .fullScreen
        new.modalTransitionStyle = .flipHorizontal // .crossDissolve - просто посередине всплывает // .coverVertical - просто снизу выходит //.partialCurl - как лист бумаги переворачивается
        
        if indexPath.row == 0 {
            new.selectedIndex = 3
        }
        else {
            new.selectedIndex = 1
        }
        
        self.present(new, animated : true, completion : nil)
        
        self.table.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print(1)
//    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        print(12345)
//
//        let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! TabBarController
//        new.modalPresentationStyle = .fullScreen
//        let tabBarController = new.tabBarController!
//        
//        if indexPath.row == 0 {
//            tabBarController.selectedIndex = 1
//        }
//        else {
//            tabBarController.selectedIndex = 3
//        }
//        
//        self.present(new, animated : false, completion : nil)
//        
//    }
    
    

    func loadQuotes() {
        Database.database().reference(fromURL: "https://activup-b45a2-default-rtdb.firebaseio.com/quotes").observe(.value, with: {(r) in
            let value = r.value as! [Any]
            quoteList = []
            for elem in value {
                if let e = elem as? String {
                    quoteList.append(e)
                }
            }        
            mainList[1] = quoteList
            self.ind.stopAnimating()
            self.table.reloadData()
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
            mainList[0] = videoList
        })
    }
}
