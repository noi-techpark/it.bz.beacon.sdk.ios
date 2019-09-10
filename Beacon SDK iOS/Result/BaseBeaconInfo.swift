import Foundation

@objc
public protocol BaseBeaconInfo {
    @objc
    func getInfo() -> BZBeaconInfo?
}
