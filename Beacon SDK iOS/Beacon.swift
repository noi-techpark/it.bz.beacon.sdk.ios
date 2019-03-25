import Foundation

public class Beacon: NSObject {
    
    public var address: String?
    public var cap: String?
    public var floor: String?
    public var id: String?
    public var instanceId: String?
    public var latitude: Float = 0.0
    public var location: String?
    public var longitude: Float = 0.0
    public var major: Int16 = 0
    public var minor: Int16 = 0
    public var name: String?
    public var namespace: String?
    public var uuid: String?
    public var website: String?
    
    static func fromInfo(info: Info) -> Beacon {
        let beacon = Beacon()
        beacon.address = info.address
        beacon.cap = info.cap
        beacon.floor = info.floor
        beacon.id = info.id
        beacon.instanceId = info.instanceId
        beacon.latitude = info.latitude!
        beacon.location = info.location
        beacon.longitude = info.longitude!
        beacon.major = Int16(info.major!)
        beacon.minor = Int16(info.minor!)
        beacon.name = info.name
        beacon.namespace = info.namespace
        beacon.uuid = info.uuid?.uuidString
        beacon.website = info.website
        return beacon
    }
    
    static func fromBeaconInfo(beaconInfo: BeaconInfo) -> Beacon {
        let beacon = Beacon()
        beacon.address = beaconInfo.value(forKey: "address") as? String
        beacon.cap = beaconInfo.value(forKey: "cap") as? String
        beacon.floor = beaconInfo.value(forKey: "floor") as? String
        beacon.id = beaconInfo.value(forKey: "id") as? String
        beacon.instanceId = beaconInfo.value(forKey: "instanceId") as? String
        beacon.latitude = beaconInfo.value(forKey: "latitude") as! Float
        beacon.location = beaconInfo.value(forKey: "location") as? String
        beacon.longitude = beaconInfo.value(forKey: "longitude") as! Float
        beacon.major = beaconInfo.value(forKey: "major") as! Int16
        beacon.minor = beaconInfo.value(forKey: "minor") as! Int16
        beacon.name = beaconInfo.value(forKey: "name") as? String
        beacon.namespace = beaconInfo.value(forKey: "namespace") as? String
        beacon.uuid = beaconInfo.value(forKey: "uuid") as? String
        beacon.website = beaconInfo.value(forKey: "website") as? String
        return beacon
    }
}
