

import UIKit
import CoreData

class LovedDataManager {
    static let shared = LovedDataManager()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveLodev(q : String) {
        let loved = Lodev(context: context)
        
        loved.quote = q
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении данных: \(error)")
        }
    }
 
    func fetchLodevStr() -> [Lodev] {
          let fetchRequest: NSFetchRequest<Lodev> = Lodev.fetchRequest()

          do {
              let p = try context.fetch(fetchRequest)
              return p
          } catch {
              print("Ошибка при загрузке данных: \(error)")
              return []
          }
      }
    
    func deleteNote(n: Lodev) {
         context.delete(n)

         do {
             try context.save()
         } catch {
             print("Ошибка при удалении данных: \(error)")
         }
     }

    func deleteAllData() {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Lodev")
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


