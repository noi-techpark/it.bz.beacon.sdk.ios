import Foundation
import KontaktSDK

public protocol BeaconScannerDelegate {
    
    func didDiscoverIBeacon(_ iBeacon: CLBeacon, beacon: BeaconInfo)
    func didDiscoverEddystone(_ eddystone: KTKEddystone, beacon: BeaconInfo)
}
