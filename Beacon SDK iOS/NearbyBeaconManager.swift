import Foundation
import KontaktSDK
import CoreData

public class NearbyBeaconManager: NSObject, KTKBeaconManagerDelegate, KTKEddystoneManagerDelegate, KTKDevicesManagerDelegate {
    
    var credentials : URLCredential?
    
    public func devicesManager(_ manager: KTKDevicesManager, didDiscover devices: [KTKNearbyDevice]) {
        for device in devices {
            NSLog("found device \(String(describing: device.name)) with battery level \(device.batteryLevel)")
            if device.batteryLevel > 0 {
                let nameParts = device.name!.components(separatedBy: "#")
                let battery = BeaconBatteryLevelUpdate.init(batteryLevel: Int(device.batteryLevel))
                SwaggerClientAPI.credential = credentials
                TrustedBeaconControllerAPI.updateUsingPATCH1WithRequestBuilder(batteryLevelUpdate: battery, id: nameParts[1]).addCredential().execute { (response, error) in
                    if error != nil {
                        NSLog("error updating beacon: \(error.debugDescription)")
                    }
                    else {
                        NSLog("beacon updated: \(String(describing: response?.body?.id))")
                    }
                }
            }
        }
    }
    
    var beaconManager: KTKBeaconManager!
    var eddystoneManager: KTKEddystoneManager!
    var secureProfileManager: KTKDevicesManager!
    var managedContext: NSManagedObjectContext!
    var delegate: BeaconScannerDelegate?
    let LAST_REFRESH = "LASTREFRESH"
    
    public static let instance: NearbyBeaconManager = {
        let instance = NearbyBeaconManager()
        return instance
    }()
    
    private override init() {
        super.init()
        Kontakt.setAPIKey(" ")
        beaconManager = KTKBeaconManager(delegate: self)
        eddystoneManager = KTKEddystoneManager(delegate: self)
        secureProfileManager = KTKDevicesManager(delegate: self)
        
        managedContext = persistentContainer.viewContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let dateNow = Date()
        if let dateLastRefresh = UserDefaults.standard.object(forKey: LAST_REFRESH) as? Date {
            if dateNow.timeIntervalSince(dateLastRefresh) > 1800 {
                refreshBeacons()
            }
        }
        else {
            refreshBeacons()
        }
        
        switch KTKBeaconManager.locationAuthorizationStatus() {
        case .notDetermined:
            break
        case .denied, .restricted:
            appendLog("No Authorization")
            break
        case .authorizedWhenInUse, .authorizedAlways:
            startScanning()
        }
    }
    
    public func setBeaconScannerDelegate(beaconScannerDelegate: BeaconScannerDelegate) {
        delegate = beaconScannerDelegate
    }
    
    public func setTrustedApiCredentials(credentials: URLCredential) {
        self.credentials = credentials
    }
    
    public func getAllBeacons() -> [BeaconInfo] {
        var beacons : [BeaconInfo] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: BeaconInfoSDK.entityName)
        let sortByNameASC = NSSortDescriptor(key: "name", ascending: true)
        let sortByIdASC = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByNameASC, sortByIdASC]
        
        do {
            var beaconInfos : [NSManagedObject] = []
            
            beaconInfos = try managedContext.fetch(fetchRequest)
            for beaconInfo in beaconInfos {
                beacons.append(BeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo as! BeaconInfoSDK))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return beacons
    }
    
    public func getBeacon(_ id: String) -> BeaconInfo? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: BeaconInfoSDK.entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            var beaconInfos : [NSManagedObject] = []
            
            beaconInfos = try managedContext.fetch(fetchRequest)
            for beaconInfo in beaconInfos {
                return BeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo as! BeaconInfoSDK)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    public func startScanning() {
        let myProximityUuid = UUID(uuidString: "6a84c716-0f2a-1ce9-f210-6a63bd873dd9")
        let region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Beacon Südtirol")
        
        if KTKBeaconManager.isMonitoringAvailable() {
            beaconManager.stopMonitoring(for: region)
            beaconManager.startMonitoring(for: region)
        }
        else {
            appendLog("Device does not support monitoring!")
        }
        
        let eddystoneRegion1 = KTKEddystoneRegion(namespaceID: "6a84c7166a63bd873dd9")
        eddystoneManager.startEddystoneDiscovery(in: eddystoneRegion1)
        appendLog("Started scanning for Eddystone beacons")
        
        secureProfileManager.startDevicesDiscovery()
    }
    
    private func appendLog(_ text: String) {
        NSLog(text)
    }
    
    func stopRanging() {
        beaconManager.stopRangingBeaconsInAllRegions()
        eddystoneManager.stopEddystoneDiscoveryInAllRegions()
    }
    
    func stopMonitoring() {
        beaconManager.stopMonitoringForAllRegions()
    }
    
    public func stopScanning() {
        stopRanging()
        stopMonitoring()
    }
    
    private func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        for beacon in beacons {
            InfoControllerAPI.getiBeaconUsingGET(major: Int(truncating: beacon.major), minor: Int(truncating: beacon.minor)) { (info: Info?, error: Error?) in self.handleIBeacon(iBeacon: beacon, info: info, error: error) }
        }
    }
    
    private func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .denied {
            stopScanning()
        }
    }
    
    private func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
        appendLog("did start monitoring for region \(region.identifier)")
    }
    
    private func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        appendLog("monitoring did fail: \((error?.localizedDescription)!)")
    }
    
    private func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
        appendLog("did enter region \(region.identifier)")
        beaconManager.startRangingBeacons(in: region)
        appendLog("Started ranging for iBeacons")
    }
    
    private func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
        appendLog("did exit region \(region.identifier)")
        beaconManager.stopRangingBeacons(in: region)
    }
    
    public func eddystoneManager(_ manager: KTKEddystoneManager, didDiscover eddystones: Set<KTKEddystone>, in region: KTKEddystoneRegion?) {
        for eddystone in eddystones {
            if let instanceId = eddystone.eddystoneUID?.instanceID {
                InfoControllerAPI.getEddyStoneUsingGET(instanceId: instanceId) { (info: Info?, error: Error?) in self.handleEddystone(eddystone: eddystone, info: info, error: error) }
            }
        }
    }
    
    public func refreshBeacons() {
        InfoControllerAPI.getListUsingGET2() { (infos: [Info]?, error: Error?) in self.handleInfos(infos: infos, error: error) }
    }
    
    func handleInfos(infos: [Info]?, error: Error?) {
        if (infos != nil) {
            for info in infos! {
                save(info: info)
//                NSLog("info: \(String(describing: info.name))")
            }
            UserDefaults.standard.set(Date(), forKey: LAST_REFRESH)
        }
    }
    
    func handleEddystone(eddystone: KTKEddystone, info: Info?, error: Error?) {
        if (info != nil) {
            appendLog(info!.name ?? "No beacon name")
            save(info: info!)
            discoveredEddystoneByInfo(eddystone: eddystone, info: info!)
        }
        else {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: BeaconInfoSDK.entityName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "instanceId == %@", eddystone.eddystoneUID!.instanceID)
            
            do {
                var beacons : [NSManagedObject] = []
                beacons = try managedContext.fetch(fetchRequest)
                for beacon in beacons {
                    if beacon.value(forKey: "name") != nil {
                        let beaconName = beacon.value(forKey: "name")!
                        let beaconId = beacon.value(forKey: "id")!
                        discoveredEddystoneByCache(eddystone: eddystone, beaconInfo: beacon as! BeaconInfoSDK)
                        appendLog("\(beaconName) (\(beaconId))")
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func handleIBeacon(iBeacon: CLBeacon, info: Info?, error: Error?) {
        if (info != nil) {
            appendLog(info!.name ?? "No beacon name")
            save(info: info!)
            discoveredIBeaconByInfo(iBeacon: iBeacon, info: info!)
        }
        else {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: BeaconInfoSDK.entityName)
            fetchRequest.fetchLimit = 1
            let predicate1 = NSPredicate(format: "major == %@", iBeacon.major.stringValue)
            let predicate2 = NSPredicate(format: "minor == %@", iBeacon.minor.stringValue)
            let predicateCompound = NSCompoundPredicate(type: .and, subpredicates: [predicate1,predicate2])
            fetchRequest.predicate = predicateCompound
            
            do {
                var beacons : [NSManagedObject] = []
                beacons = try managedContext.fetch(fetchRequest)
                for beacon in beacons {
                    if beacon.value(forKey: "name") != nil {
                        let beaconName = beacon.value(forKey: "name")!
                        let beaconId = beacon.value(forKey: "id")!
                        discoveredIBeaconByCache(iBeacon: iBeacon, beaconInfo: beacon as! BeaconInfoSDK)
                        appendLog("\(beaconName) (\(beaconId))")
                    }
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func discoveredIBeaconByInfo(iBeacon: CLBeacon, info: Info) {
        delegate?.didDiscoverIBeacon(iBeacon, beacon: BeaconInfo.fromInfo(info: info))
    }
    
    func discoveredIBeaconByCache(iBeacon: CLBeacon, beaconInfo: BeaconInfoSDK) {
        delegate?.didDiscoverIBeacon(iBeacon, beacon: BeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo))
    }
    
    func discoveredEddystoneByInfo(eddystone: KTKEddystone, info: Info) {
        delegate?.didDiscoverEddystone(eddystone, beacon: BeaconInfo.fromInfo(info: info))
    }
    
    func discoveredEddystoneByCache(eddystone: KTKEddystone, beaconInfo: BeaconInfoSDK) {
        delegate?.didDiscoverEddystone(eddystone, beacon: BeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo))
    }
    
    func save(info: Info) {
        
        let entity = NSEntityDescription.entity(forEntityName: BeaconInfoSDK.entityName, in: managedContext)!
        let beacon = NSManagedObject(entity: entity, insertInto: managedContext)
        
        beacon.setValue(info.id, forKeyPath: "id")
        beacon.setValue(info.address, forKeyPath: "address")
        beacon.setValue(info.cap, forKeyPath: "cap")
        beacon.setValue(info.floor, forKeyPath: "floor")
        beacon.setValue(info.instanceId, forKeyPath: "instanceId")
        beacon.setValue(info.latitude, forKeyPath: "latitude")
        beacon.setValue(info.longitude, forKeyPath: "longitude")
        beacon.setValue(info.location, forKeyPath:"location")
        beacon.setValue(info.major, forKeyPath: "major")
        beacon.setValue(info.minor, forKeyPath: "minor")
        beacon.setValue(info.name, forKeyPath: "name")
        beacon.setValue(info.namespace, forKeyPath:"namespace")
        beacon.setValue(info.uuid?.uuidString, forKeyPath: "uuid")
        beacon.setValue(info.website, forKeyPath: "website")
        
        do {
            try managedContext.save()
            //            print("Saved \(String(describing: info.name))")
        } catch let error as NSError {
            appendLog("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    private func beaconManager(_ manager: KTKBeaconManager, didDetermineState state: CLRegionState, for region: KTKBeaconRegion) {
        appendLog("did determine state \(state.rawValue) for region \(region.identifier)")
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = PersistentContainer(name: "Beacon")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
