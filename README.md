# Beacon Suedtirol - Alto Adige SDK iOS
## Installation guide
### Prerequisits
- IDE (XCode 10 recommended)
- pod (you can get it from https://cocoapods.org/)
#### 1. Open the pod file of your project
#### 2. Add the following line to relevant targets
```
pod 'BZBeaconSDK', '~> 0.0.1'
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
