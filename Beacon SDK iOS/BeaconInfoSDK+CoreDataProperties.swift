// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import Foundation
import CoreData


extension BeaconInfoSDK {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BeaconInfoSDK> {
        return NSFetchRequest<BeaconInfoSDK>(entityName: "BeaconInfoSDK")
    }

    @NSManaged public var address: String?
    @NSManaged public var cap: String?
    @NSManaged public var floor: String?
    @NSManaged public var id: String?
    @NSManaged public var instanceId: String?
    @NSManaged public var latitude: Float
    @NSManaged public var location: String?
    @NSManaged public var longitude: Float
    @NSManaged public var major: Int32
    @NSManaged public var minor: Int32
    @NSManaged public var name: String?
    @NSManaged public var namespace: String?
    @NSManaged public var uuid: String?
    @NSManaged public var website: String?
    @NSManaged public var updatedAt: Int64

}
