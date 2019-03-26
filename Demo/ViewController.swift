//
//  ViewController.swift
//  Demo
//
//  Created by Johannes Andrich on 26.03.19.
//  Copyright © 2019 Johannes Andrich. All rights reserved.
//

import UIKit
import Beacon_SDK_iOS

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let manager = NearbyBeaconManager.instance
        manager.refreshBeacons()
        
        let beacon = manager.getBeacon("cZyH1K")
        NSLog("beacon: \(beacon?.name)")
    }


}

