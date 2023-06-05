// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

import Foundation
import KontaktSDK

@objc
public protocol BZBeaconScannerDelegate {
    
    @objc
    func didDiscoverIBeacon(_ iBeacon: IBeacon)
    @objc
    func didDiscoverEddystone(_ eddystone: Eddystone)
}
