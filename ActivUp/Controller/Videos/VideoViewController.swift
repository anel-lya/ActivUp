import FirebaseStorage
import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = back
        table.backgroundView?.backgroundColor = back
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "video_cell") as! VideoTableViewCell
        
        let elem = (videoList[indexPath.row])
        let str = elem.split(separator: "|")[0]
        cell.textt.text = String(str)
        
        cell.textt.textColor = front
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        
        let elem = videoList[indexPath.row]
        let uri = elem.split(separator: "|")[1]
        
        if let url = URL(string: String(uri)) {
            UIApplication.shared.open(url)
        }
    }
    
}
