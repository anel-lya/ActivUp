import UIKit

class LovedTableViewCell: UITableViewCell {

    @IBOutlet weak var v: UIView!
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        v.layer.cornerRadius = 20
       
    }

}
