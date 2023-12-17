

import UIKit
import CoreData

class DataManager {
    static let shared = DataManager()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveProfile(imgg : Data, email : String) {
        deleteAllData()
        let per = Profile(context: context)
        
        print(imgg)

        per.imgD = imgg
        let l = email.split(separator: "@")
        per.nick = String(l[0])
        per.mail = email
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении данных: \(error)")
        }
    }
 
    func fetchProfileStr() -> [Profile] {
          let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()

          do {
              let p = try context.fetch(fetchRequest)
              return p
          } catch {
              print("Ошибка при загрузке данных: \(error)")
              return []
          }
      }

    func deleteAllData() {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Error deleting data : \(error)")
        }
        saveContext()
    }
    
    func saveContext() {
          if context.hasChanges {
              do {
                  try context.save()
              } catch {
                  print("Error saving context: \(error)")
              }
          }
      }
}


