import Foundation
import CoreData

extension NSPersistentContainer {

    typealias ErrorHandler = (NSError) -> Void

    convenience init(defaultContainerWithName name : String, inMemory : Bool = false, errorHandler : ErrorHandler? = nil) {

        self.init(name: name)

        if inMemory {
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            self.persistentStoreDescriptions = [description]
        }

        self.loadPersistentStores(completionHandler: { (storeDescription, error) in

            if let url = storeDescription.url {
                debugPrint("Core Data database URL", url.path) //kann mit sqlite3 im Terminal aufgerufen werden
            }

            if let error = error as NSError? {
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */

                if let errorHandler = errorHandler {
                    errorHandler(error)
                } else {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
        })
    }

    func saveViewContext() throws {
        assert(Thread.isMainThread)

        let context = self.viewContext
        if context.hasChanges {
            try context.save()
        }
    }

}
