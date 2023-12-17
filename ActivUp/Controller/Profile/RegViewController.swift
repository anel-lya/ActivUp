
import UIKit
import FirebaseAuth


class RegViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var imageP: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    @IBAction func addIm(_ sender: Any) {
        
        ImagePickerManager().pickImage(self) { image in
            self.imageP.image = image
        }
        
    }
    
    
    @IBAction func signUp(_ sender: Any) {
        
        if let i = self.imageP.image?.pngData(){
            DataManager.shared.saveProfile(imgg: i, email: email.text!)
        }
        else {
            DataManager.shared.saveProfile(imgg: Data(), email: email.text!)
        }
        
        if let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? TabBarController {
            new.modalPresentationStyle = .fullScreen
            self.present(new, animated : false, completion : nil)
        }
        
        
        
//        let e = email.text!
//        
//        if e.isEmpty || !e.contains("@") {
//            let alert = UIAlertController(title:  "ой", message:  "Заполните, пожалуйста, вашу почту!", preferredStyle:  .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default))
//            self.present(alert, animated: false,completion: nil)
//        }
//        else {
//            Auth.auth().createUser(withEmail: e, password: e){
//                authResult, error in
//                if let _ = error {
//                    let alert = UIAlertController(title:  "ой", message:  "Произошла ошибка.\nПопробуйте, пожалуйста, позже!", preferredStyle:  .alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
//                    self.present(alert, animated: false,completion: nil)
//                }
//                if let _ = authResult {
//                    
//                    // не правильно переводится картинка в строку
//                    
////                    DataManager.shared.saveProfile(imgg: self.imageP.image?.toPngString() ?? "", email: e)
//                    
//                    if let new = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as? TabBarController {
//                        new.modalPresentationStyle = .fullScreen
//                        self.present(new, animated : false, completion : nil)
//                    }
//                }
//            }
//        }
//        
    }
    
}


