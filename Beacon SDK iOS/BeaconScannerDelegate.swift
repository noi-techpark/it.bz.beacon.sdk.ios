import Foundation
import KontaktSDK

public protocol BeaconScannerDelegate {
    
    func didDiscoverIBeacon(_ iBeacon: CLBeacon, beacon: Beacon)
    func didDiscoverEddystone(_ eddystone: KTKEddystone, beacon: Beacon)
}
