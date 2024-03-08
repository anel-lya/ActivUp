import UIKit

class BooksTableViewCell: UITableViewCell {

 
    @IBOutlet weak var lblBook: UILabel!
    @IBOutlet weak var lblAu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = back
        lblAu.textColor = front
        lblBook.textColor = front
        
        print(front, back)
        
    }


}
