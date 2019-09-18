import Foundation
import CoreData


extension BatteryLevelInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BatteryLevelInfo> {
        return NSFetchRequest<BatteryLevelInfo>(entityName: "BatteryLevelInfo")
    }

    @NSManaged public var id: String?
    @NSManaged public var batteryLevel: Int16
    @NSManaged public var lastSent: Int64
    @NSManaged public var lastUpdated: Int64

}
