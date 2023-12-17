

import UIKit
import CoreData

class IsFirstDataManager {
    static let shared = IsFirstDataManager()

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func saveTrue() {
        let loved = IsFirst(context: context)
        
        loved.iss = true
        do {
            try context.save()
        } catch {
            print("Ошибка при сохранении данных: \(error)")
        }
    }
 
    func fetchIsFirst() -> Bool {
          let fetchRequest: NSFetchRequest<IsFirst> = IsFirst.fetchRequest()

          do {
              let p = try context.fetch(fetchRequest)
              if p.count > 0 {
                  return p.first!.iss
              }
              else {
                  return false
              }
          } catch {
              print("Ошибка при загрузке данных: \(error)")
              return false
          }
      }
    
}


