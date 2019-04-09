import Foundation
import KontaktSDK

public protocol BZBeaconScannerDelegate {
    
    func didDiscoverIBeacon(_ iBeacon: IBeacon)
    func didDiscoverEddystone(_ eddystone: Eddystone)
}
