<!--
SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>

SPDX-License-Identifier: CC0-1.0
-->

# Beacon Suedtirol - Alto Adige SDK iOS
This repository contains the mobile iOS SDK that can be used in order to read the beacons installed within the Beacon Suedtirol project.

[![REUSE Compliance](https://github.com/noi-techpark/it.bz.beacon.sdk.ios/actions/workflows/reuse.yml/badge.svg)](https://github.com/noi-techpark/odh-docs/wiki/REUSE#badges)
[![CI](https://github.com/noi-techpark/it.bz.beacon.sdk.ios/actions/workflows/ci.yml/badge.svg)](https://github.com/noi-techpark/it.bz.beacon.sdk.ios/actions/workflows/ci.yml)

## Usage
#### Prerequisits
- IDE (XCode 10 recommended)
- pod (you can get it from https://cocoapods.org/)
#### 1. Open the pod file of your project
#### 2. Add the following line to relevant targets (look for latest release in repository and replace "x.y.z")
```
pod 'BZBeaconSDK', '~> x.y.z'
```
#### 3. Open "Your App Name".xcworkspace with your IDE

#### 4. Let your ViewController implement the delegate BZBeaconScannerDelegate
```
class YourViewController: BZBeaconScannerDelegate 
``` 

#### 5. Get and use an instance of the BZNearbyBeaconManager
```
let manager = BZNearbyBeaconManager.instance
manager.setBeaconScannerDelegate(beaconScannerDelegate: self)
manager.startScanning()
``` 
#### 6. Implement the functions you're interested in, for example:
```
func didDiscoverIBeacon(_ iBeacon: IBeacon) {
    ...
}
``` 

#### 7. Build and Launch the App

#### 8. (Optional) Implement a background data fetch
Offer a better experience to your app users by implementing a background data fetch in your app. This will check periodically for updated beacon infos. By doing so, you ensure that your users will always see fresh data, even when they are offline.

##### 8.1 Enable the background fetch capability
Select your app target, and under `Capabilities`, activate `Background Modes` -> `Background fetch`
##### 8.2 Set the desired update interval
In the `didFinishLaunchingWithOptions` method of your `AppDelegate`, add the following line:
```
UIApplication.shared.setMinimumBackgroundFetchInterval(1800)
```
This sets the update in seconds. 30 Minutes as in this example is the minimum.
##### 8.3 Call the SDK method to refresh beacons by adding this method to your `AppDelegate`:
```
  func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

        let manager = BZNearbyBeaconManager.instance
        manager.refreshBeacons() {infos in
            if (infos != -1) {
                if (infos! > 0) {
                    completionHandler(.newData)
                } else {
                    completionHandler(.noData)
                }
            } else {
                completionHandler(.failed)
            }
        }
    }
```
You can modify this method if you need, but always call the completionHandler as in this example since this is important for future scheduling of the task!

# Inbound Licenses
- KontaktSDK - Creative Commons Attribution NoDerivs (CC-ND)
- Alamofire - MIT

# Outbound License
See LICENSE.md

## REUSE

This project is [REUSE](https://reuse.software) compliant, more information about the usage of REUSE in NOI Techpark repositories can be found [here](https://github.com/noi-techpark/odh-docs/wiki/Guidelines-for-developers-and-licenses#guidelines-for-contributors-and-new-developers).

Since the CI for this project checks for REUSE compliance you might find it useful to use a pre-commit hook checking for REUSE compliance locally. The [pre-commit-config](.pre-commit-config.yaml) file in the repository root is already configured to check for REUSE compliance with help of the [pre-commit](https://pre-commit.com) tool.

Install the tool by running:
```bash
pip install pre-commit
```
Then install the pre-commit hook via the config file by running:
```bash
pre-commit install
```
