import Foundation

@objc
open class IBeacon : NSObject, BaseBeaconInfo {
    
    public var uuid: String?
    public var major: Int32?
    public var minor: Int32?
    public var info: BZBeaconInfo?
    
    public init(uuid: String?, major: Int32?, minor: Int32?, info: BZBeaconInfo?) {
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.info = info
    }
    
    @objc
    public func getInfo() -> BZBeaconInfo? {
        return info
    }
}
