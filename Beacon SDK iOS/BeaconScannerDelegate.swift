import Foundation
import KontaktSDK

public protocol BeaconScannerDelegate {
    
    func didDiscoverIBeacon(_ iBeacon: IBeacon)
    func didDiscoverEddystone(_ eddystone: Eddystone)
}
