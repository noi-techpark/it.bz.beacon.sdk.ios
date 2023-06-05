// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import UIKit
import Beacon_SDK_iOS

class BeaconTableViewController: UITableViewController, BZBeaconScannerDelegate {
    
    var beacons = [BZBeaconInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let manager = BZNearbyBeaconManager.instance
        manager.setBeaconScannerDelegate(beaconScannerDelegate: self)
        manager.startScanning()
    }
    
    func didDiscoverIBeacon(_ iBeacon: IBeacon) {
        NSLog("App did discover iBeacon: %@", iBeacon.getInfo()?.name ?? "(no name)")
        let beacon = BZBeaconInfo()
        beacon.name = iBeacon.getInfo()?.name
        beacon.id = iBeacon.getInfo()?.id
        beacon.address = iBeacon.getInfo()?.address
        beacon.instanceId = iBeacon.uuid
        eventuallyAddToList(beacon)
    }
    
    func didDiscoverEddystone(_ eddystone: Eddystone) {
        NSLog("App did discover Eddystone: %@", eddystone.getInfo()?.name ?? "(no name)")
        let beacon = BZBeaconInfo()
        beacon.name = eddystone.getInfo()?.name
        beacon.id = eddystone.getInfo()?.id
        beacon.address = eddystone.getInfo()?.address
        beacon.instanceId = eddystone.instanceId
        eventuallyAddToList(beacon)
    }
    
    func eventuallyAddToList(_ newBeacon: BZBeaconInfo) {
        var isInList = false
        for beacon in beacons {
            if beacon.id == newBeacon.id {
                isInList = true
            }
        }
        if !isInList {
            beacons.append(newBeacon)
            beacons = beacons.sorted(by: {$0.name ?? "" < $1.name ?? ""})
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beacons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "BeaconTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BeaconTableViewCell else {
            fatalError("The dequeued cell is not an instance of BeaconTableViewCell.")
        }
        
        let beacon = beacons[indexPath.row]
        cell.labelName.text = beacon.name
        cell.labelAddress.text = beacon.address
        cell.labelInstanceId.text = beacon.instanceId

        return cell
    }
}
