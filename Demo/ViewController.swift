import UIKit
import Foundation
import KontaktSDK
import Beacon_SDK_iOS

class ViewController: UIViewController, BeaconScannerDelegate {
    
    func didDiscoverIBeacon(_ iBeacon: IBeacon) {
        NSLog("App did discover iBeacon: %@", iBeacon.getInfo()?.name ?? "(no name)")
    }
    
    func didDiscoverEddystone(_ eddystone: Eddystone) {
        NSLog("App did discover Eddystone: %@", eddystone.getInfo()?.name ?? "(no name)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = NearbyBeaconManager.instance
        manager.refreshBeacons()
        manager.setBeaconScannerDelegate(beaconScannerDelegate: self)
        manager.startScanning()
    }
}

