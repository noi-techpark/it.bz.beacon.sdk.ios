// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import Foundation

@objcMembers
public class BZBeaconInfo: NSObject {
    
    public var address: String?
    public var cap: String?
    public var floor: String?
    public var id: String?
    public var instanceId: String?
    public var latitude: Double = 0.0
    public var location: String?
    public var longitude: Double = 0.0
    public var major: Int32 = 0
    public var minor: Int32 = 0
    public var name: String?
    public var namespace: String?
    public var updatedAt: Int64 = 0
    public var uuid: String?
    public var website: String?
    
    static func fromInfo(info: Info) -> BZBeaconInfo {
        let beacon = BZBeaconInfo()
        beacon.address = info.address
        beacon.cap = info.cap
        beacon.floor = info.floor
        beacon.id = info.id
        beacon.instanceId = info.instanceId
        beacon.latitude = info.latitude!
        beacon.location = info.location
        beacon.longitude = info.longitude!
        beacon.major = Int32(info.major!)
        beacon.minor = Int32(info.minor!)
        beacon.name = info.name
        beacon.namespace = info.namespace
        if (info.updatedAt != nil) {
            beacon.updatedAt = info.updatedAt!
        }
        beacon.uuid = info.uuid?.uuidString
        beacon.website = info.website
        return beacon
    }
    
    static func fromBeaconInfoSDK(beaconInfo: BeaconInfoSDK) -> BZBeaconInfo {
        let beacon = BZBeaconInfo()
        beacon.address = beaconInfo.value(forKey: "address") as? String
        beacon.cap = beaconInfo.value(forKey: "cap") as? String
        beacon.floor = beaconInfo.value(forKey: "floor") as? String
        beacon.id = beaconInfo.value(forKey: "id") as? String
        beacon.instanceId = beaconInfo.value(forKey: "instanceId") as? String
        beacon.latitude = beaconInfo.value(forKey: "latitude") as! Double
        beacon.location = beaconInfo.value(forKey: "location") as? String
        beacon.longitude = beaconInfo.value(forKey: "longitude") as! Double
        beacon.major = beaconInfo.value(forKey: "major") as! Int32
        beacon.minor = beaconInfo.value(forKey: "minor") as! Int32
        beacon.name = beaconInfo.value(forKey: "name") as? String
        beacon.namespace = beaconInfo.value(forKey: "namespace") as? String
        beacon.updatedAt = beaconInfo.value(forKey: "updatedAt") as! Int64
        beacon.uuid = beaconInfo.value(forKey: "uuid") as? String
        beacon.website = beaconInfo.value(forKey: "website") as? String
        return beacon
    }
}
