import Foundation
import CoreData

extension Beacon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beacon> {
        return NSFetchRequest<Beacon>(entityName: "Beacon")
    }

    @NSManaged public var address: String?
    @NSManaged public var cap: String?
    @NSManaged public var floor: String?
    @NSManaged public var id: String?
    @NSManaged public var instanceId: String?
    @NSManaged public var latitude: Float
    @NSManaged public var location: String?
    @NSManaged public var longitude: Float
    @NSManaged public var major: Int16
    @NSManaged public var minor: Int16
    @NSManaged public var name: String?
    @NSManaged public var namespace: String?
    @NSManaged public var uuid: String?
    @NSManaged public var website: String?
}
