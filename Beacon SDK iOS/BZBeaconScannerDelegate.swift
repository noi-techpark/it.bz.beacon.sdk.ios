import Foundation
import KontaktSDK

@objc
public protocol BZBeaconScannerDelegate {
    
    @objc
    func didDiscoverIBeacon(_ iBeacon: IBeacon)
    @objc
    func didDiscoverEddystone(_ eddystone: Eddystone)
}
