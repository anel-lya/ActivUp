
import UIKit

class ProfileViewController: UIViewController  {

    
    @IBOutlet weak var viewReg: UIView!
    
    @IBOutlet weak var warn: UILabel!
    @IBOutlet weak var imgg: UIImageView!
    @IBOutlet weak var nick: UILabel!
    @IBOutlet weak var viewData: UIView!
    @IBOutlet weak var mail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warn.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        warn.addGestureRecognizer(tapGesture)



        let p = DataManager.shared.fetchProfileStr()
        if (p.count > 0) {
            viewReg.isHidden = true
            viewData.isHidden = false
            
            nick.text = p[0].nick!
            mail.text = p[0].mail
            
            if !p[0].imgD!.isEmpty{
                warn.isHidden = true
                imgg.image = UIImage(data: p[0].imgD!)
            }
            else {
                warn.isHidden = false
            }
        }
        else {
            viewReg.isHidden = false
            viewData.isHidden = true
        }
 

    }
    
    @objc func labelTapped() {
            
        ImagePickerManager().pickImage(self) { image in
            DataManager.shared.saveProfile(imgg: image.pngData()!, email: self.mail.text!)
            self.viewDidLoad()
        }
        
    }


 
    

}

// добавить дату регистрации и потом в профиле выводить сколько дней пользовательс нами
