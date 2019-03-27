import UIKit
import KontaktSDK
import Beacon_SDK_iOS

class ViewController: UIViewController, BeaconScannerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = NearbyBeaconManager.instance
        manager.refreshBeacons()
        manager.setBeaconScannerDelegate(beaconScannerDelegate: self)
        manager.startScanning()
    }
    
    func didDiscoverIBeacon(_ iBeacon: CLBeacon, beacon: BeaconInfo) {
        NSLog("didDiscoverIBeacon: \(String(describing: beacon.name))")
    }
    
    func didDiscoverEddystone(_ eddystone: KTKEddystone, beacon: BeaconInfo) {
        NSLog("didDiscoverEddystone: \(String(describing: beacon.name))")
    }
}

