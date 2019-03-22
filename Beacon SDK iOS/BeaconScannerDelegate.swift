import Foundation

public protocol BeaconScannerDelegate {
    
    func didDisconverIBeacon(_ iBeacon:Info)
    func didDisconverEddystone(_ eddystone:Info)
}
