import UIKit
import KontaktSDK
import Beacon_SDK_iOS

class ViewController: UIViewController, BeaconScannerDelegate {
    
    func didDiscoverIBeacon(_ iBeacon: CLBeacon, beacon: Beacon) {
        NSLog("didDiscoverIBeacon: \(String(describing: beacon.name))")
    }
    
    func didDiscoverEddystone(_ eddystone: KTKEddystone, beacon: Beacon) {
        NSLog("didDiscoverEddystone: \(String(describing: beacon.name))")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = NearbyBeaconManager.instance
        manager.refreshBeacons()
        manager.setBeaconScannerDelegate(beaconScannerDelegate: self)
        manager.startScanning()
    }
}

