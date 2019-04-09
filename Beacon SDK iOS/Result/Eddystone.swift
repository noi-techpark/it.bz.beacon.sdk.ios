import Foundation

open class Eddystone : BaseBeaconInfo {
    
    public var namespace: String?
    public var instanceId:String?
    public var url: String?
    public var eid: String?
    public var encryptedTelemetry: String?
    public var batteryVoltage: Double?
    public var temperature: Double?
    public var info: BZBeaconInfo?
    
    public init(namespace: String?, instanceId: String?, url: String?, eid: String?, encryptedTelemetry: String?, batteryVoltage: Double?, temperature: Double?, info: BZBeaconInfo?) {
        self.namespace = namespace
        self.instanceId = instanceId
        self.url = url
        self.eid = eid
        self.encryptedTelemetry = encryptedTelemetry
        self.batteryVoltage = batteryVoltage
        self.temperature = temperature
        self.info = info
    }
    
    public func getInfo() -> BZBeaconInfo? {
        return info
    }
}
