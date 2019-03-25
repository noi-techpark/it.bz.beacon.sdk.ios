import Foundation

public protocol BeaconScannerDelegate {
    
    func didDiscoverBeacon(_ beacon: Beacon)
}
