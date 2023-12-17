import FirebaseStorage
import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var lblwait: UILabel!
    @IBOutlet weak var ind: UIActivityIndicatorView!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = back
        table.backgroundView?.backgroundColor = back
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 100.0
        
        
        lblwait.isHidden = true

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
        
        let elem = (videoList[indexPath.row]).replacingOccurrences(of: ".mp4", with: " ")
        let str = elem.split(separator: "/")[1]
        cell.textt.text = String(str)
        
        cell.textt.textColor = front
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ind.startAnimating()
        lblwait.isHidden = false
        table.deselectRow(at: indexPath, animated: true)
        
        let elem = videoList[indexPath.row]
        
        let ud = Storage.storage().reference(withPath: elem)
        let _ = ud.getData (maxSize: 100 * 1024 * 1024) { (data , error ) in
            if let error = error {
                print ("ERROR - ", error.localizedDescription)
                return
            }
            if let data = data {
                self.ind.stopAnimating()
                self.lblwait.isHidden = true
                print ("DATA - ", data)

                let player = AVPlayerViewController()
                let t = AVPlayerItem(url: createURL(from: data, fileExtension: "mp4")!)
                player.player = AVPlayer(playerItem: t)
                self.present(player, animated: true)
                player.player?.play()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let len = Double((videoList[indexPath.row]).count)
        
        return ceil(len/30) * 50
        
    }
    
   /* func downloadFileFromStorage() {
        let storage = Storage.storage()
        let storageReference = storage.reference()

        let youtube = videoList.keys
        for y in youtube {
            let folderReference = storageReference.child(y.chanel)
            
            print(100 * 1024 * 1024)
            
            folderReference.listAll { result, error in
                if let error = error {
                    print("Ошибка при получении списка файлов: \(error.localizedDescription)")
                } else {
                    for fileReference in result!.items {
                        fileReference.getData(maxSize: 100 * 1024 * 1024) { data, error in
                            if let error = error {
                                print("Ошибка при скачивании файла \(fileReference.name): \(error.localizedDescription)")
                            } else {
                                if let fileData = data {
                                    var list = videoList[y]!
                                    list.append(fileData)
                                    videoList[y] = list
                                    print("Файл \(fileReference.name) успешно скачан и обработан")
            }}}}}}}
        
        
    }*/


}



func createURL(from data: Data, fileExtension: String) -> URL? {
    do {
        // Get the document directory URL
        let documentsDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

        // Create a unique filename with the specified file extension
        let fileName = UUID().uuidString + "." + fileExtension

        // Append the filename to the document directory URL
        let fileURL = documentsDirectory.appendingPathComponent(fileName)

        // Write the data to the file
        try data.write(to: fileURL)

        return fileURL
    } catch {
        print("Error creating URL from data: \(error)")
        return nil
    }
}
