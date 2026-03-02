import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    let persistentContainer: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "RPGYM")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error saving Core Data: \(error)")
            }
        }
    }
}
