import Foundation
import KontaktSDK
import CoreData

@objc
public class BZNearbyBeaconManager: NSObject, KTKBeaconManagerDelegate, KTKEddystoneManagerDelegate, KTKDevicesManagerDelegate {
    
    var beaconManager: KTKBeaconManager!
    var eddystoneManager: KTKEddystoneManager!
    var secureProfileManager: KTKDevicesManager!
    var managedContext: NSManagedObjectContext!
    var delegate: BZBeaconScannerDelegate?
    let LAST_REFRESH = "LASTREFRESH"
    var startRequested = false
    var scanning = false;
    
    @objc
    public static let instance: BZNearbyBeaconManager = {
        let instance = BZNearbyBeaconManager()
        return instance
    }()
    
    private override init() {
        super.init()
        Kontakt.setAPIKey(" ")
        beaconManager = KTKBeaconManager(delegate: self)
        beaconManager.requestLocationAlwaysAuthorization()
        eddystoneManager = KTKEddystoneManager(delegate: self)
        secureProfileManager = KTKDevicesManager(delegate: self)
        
        managedContext = persistentContainer.viewContext
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let dateNow = Date()
        if let dateLastRefresh = UserDefaults.standard.object(forKey: LAST_REFRESH) as? Date {
            if dateNow.timeIntervalSince(dateLastRefresh) > 1800 {
                refreshBeacons() {infos in
                    
                }
            }
        }
        else {
            refreshBeacons() {infos in
            }
        }
    }
    
    @objc
    public func setBeaconScannerDelegate(beaconScannerDelegate: BZBeaconScannerDelegate) {
        delegate = beaconScannerDelegate
    }
    
    @objc
    public func setTrustedApiCredentials(credentials: URLCredential) {
        SwaggerClientAPI.credential = credentials
    }
    
    @objc
    public func isScanning() -> Bool {
        return scanning
    }
    
    @objc
    public func getAllBeacons() -> [BZBeaconInfo] {
        var beacons : [BZBeaconInfo] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: BeaconInfoSDK.entityName)
        let sortByNameASC = NSSortDescriptor(key: "name", ascending: true)
        let sortByIdASC = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortByNameASC, sortByIdASC]
        
        do {
            var beaconInfos : [NSManagedObject] = []
            
            beaconInfos = try managedContext.fetch(fetchRequest)
            for beaconInfo in beaconInfos {
                beacons.append(BZBeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo as! BeaconInfoSDK))
            }
        } catch let error as NSError {
            NSLog("Could not fetch. \(error), \(error.userInfo)")
        }
        return beacons
    }
    
    @objc
    public func getBeacon(_ id: String) -> BZBeaconInfo? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: BeaconInfoSDK.entityName)
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            var beaconInfos : [NSManagedObject] = []
            
            beaconInfos = try managedContext.fetch(fetchRequest)
            for beaconInfo in beaconInfos {
                return BZBeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo as! BeaconInfoSDK)
            }
        } catch let error as NSError {
            NSLog("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
    @objc
    public func startScanning() {
        startRequested = true
        if (!scanning) {
            scanning = true
            let myProximityUuid = UUID(uuidString: "6a84c716-0f2a-1ce9-f210-6a63bd873dd9")
            let region = KTKBeaconRegion(proximityUUID: myProximityUuid!, identifier: "Beacon Südtirol")
            
            switch KTKBeaconManager.locationAuthorizationStatus() {
            case .authorizedAlways:
                if KTKBeaconManager.isMonitoringAvailable() {
                    beaconManager.stopMonitoring(for: region)
                    beaconManager.startMonitoring(for: region)
//                    NSLog("Started scanning for iBeacons")
                }
                else {
                    NSLog("Device does not support monitoring!")
                }
                break
            default: break
            }
            
            let eddystoneRegion = KTKEddystoneRegion(namespaceID: "6a84c7166a63bd873dd9")
            eddystoneManager.startEddystoneDiscovery(in: eddystoneRegion)
//            NSLog("Started scanning for Eddystone beacons")
            secureProfileManager.startDevicesDiscovery()
        }
    }
    
    func stopRanging() {
        beaconManager.stopRangingBeaconsInAllRegions()
        eddystoneManager.stopEddystoneDiscoveryInAllRegions()
    }
    
    func stopMonitoring() {
        beaconManager.stopMonitoringForAllRegions()
    }
    
    @objc
    public func stopScanning() {
        scanning = false
        startRequested = false
        stopRanging()
        stopMonitoring()
    }
    
    public func beaconManager(_ manager: KTKBeaconManager, didRangeBeacons beacons: [CLBeacon], in region: KTKBeaconRegion) {
        for iBeacon in beacons {
            let fetchRequest:NSFetchRequest<BeaconInfoSDK> = BeaconInfoSDK.fetchRequest()
            fetchRequest.fetchLimit = 1
            let predicate1 = NSPredicate(format: "major == %@", iBeacon.major.stringValue)
            let predicate2 = NSPredicate(format: "minor == %@", iBeacon.minor.stringValue)
            let predicateCompound = NSCompoundPredicate(type: .and, subpredicates: [predicate1,predicate2])
            fetchRequest.predicate = predicateCompound
            
            do {
                for beacon in try managedContext.fetch(fetchRequest) as [BeaconInfoSDK]? ?? [] {
                    if beacon.name != nil {
                        discoveredIBeaconByCache(iBeacon: iBeacon, beaconInfo: beacon)
                    }
                }
            } catch let error as NSError {
                NSLog("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    public func beaconManager(_ manager: KTKBeaconManager, didChangeLocationAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            if (startRequested) {
                startScanning()
            }
            break
        default: scanning = false
        }
    }
    
    public func beaconManager(_ manager: KTKBeaconManager, didStartMonitoringFor region: KTKBeaconRegion) {
//        NSLog("did start monitoring for region \(region.identifier)")
        beaconManager.requestState(for: region)
    }
    
    public func beaconManager(_ manager: KTKBeaconManager, monitoringDidFailFor region: KTKBeaconRegion?, withError error: Error?) {
        NSLog("monitoring did fail: \((error?.localizedDescription)!)")
    }
    
    public func beaconManager(_ manager: KTKBeaconManager, didEnter region: KTKBeaconRegion) {
//        NSLog("did enter region \(region.identifier)")
        beaconManager.startRangingBeacons(in: region)
//        NSLog("Started ranging for iBeacons")
    }
    
    public func beaconManager(_ manager: KTKBeaconManager, didExitRegion region: KTKBeaconRegion) {
//        NSLog("did exit region \(region.identifier)")
        beaconManager.stopRangingBeacons(in: region)
    }
    
    @objc
    public func eddystoneManager(_ manager: KTKEddystoneManager, didDiscover eddystones: Set<KTKEddystone>, in region: KTKEddystoneRegion?) {
        for eddystone in eddystones {
            let fetchRequest:NSFetchRequest<BeaconInfoSDK> = BeaconInfoSDK.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "instanceId == %@", eddystone.eddystoneUID!.instanceID)
            
            do {
                for beacon in try managedContext.fetch(fetchRequest) as [BeaconInfoSDK]? ?? [] {
                    if beacon.name != nil {
                        discoveredEddystoneByCache(eddystone: eddystone, beaconInfo: beacon)
                    }
                }
            } catch let error as NSError {
                NSLog("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    @objc
    public func devicesManager(_ manager: KTKDevicesManager, didDiscover devices: [KTKNearbyDevice]) {
        if (SwaggerClientAPI.credential != nil) {
            let dateNow = Date()
            for device in devices {
                if device.batteryLevel > 0 {
                    if (device.name != nil) {
                        let nameParts = device.name!.components(separatedBy: "#")
                        if (nameParts.count > 1) {
                            let id = nameParts[1]
                            var dateLastSent = Date(timeIntervalSince1970: TimeInterval(0))
                            
                            let fetchRequest:NSFetchRequest<BatteryLevelInfo> = BatteryLevelInfo.fetchRequest()
                            fetchRequest.fetchLimit = 1
                            let predicate1 = NSPredicate(format: "id == %@", id)
                            fetchRequest.predicate = predicate1
                            
                            do {
                                let batteryLevelInfos = try managedContext.fetch(fetchRequest)
                                
                                if let batteryLevelInfo = batteryLevelInfos.first {
                                    dateLastSent = Date(timeIntervalSince1970: TimeInterval(batteryLevelInfo.lastSent))
                                    batteryLevelInfo.setValue(dateNow.timeIntervalSince1970, forKey: "lastUpdated")
                                    batteryLevelInfo.setValue(Int(device.batteryLevel), forKey: "batteryLevel")
                                } else {
                                    let entity = NSEntityDescription.entity(forEntityName: BatteryLevelInfo.entityName, in: managedContext)!
                                    let batteryLevelInfo = NSManagedObject(entity: entity, insertInto: managedContext)
                                    
                                    batteryLevelInfo.setValue(id, forKeyPath: "id")
                                    batteryLevelInfo.setValue(dateNow.timeIntervalSince1970, forKey: "lastUpdated")
                                    batteryLevelInfo.setValue(Int(device.batteryLevel), forKey: "batteryLevel")
                                    
                                    try managedContext.save()
                                }
                                if dateLastSent.timeIntervalSince(dateNow) < -86400 {
                                    let battery = BeaconBatteryLevelUpdate.init(batteryLevel: Int(device.batteryLevel))
                                    TrustedBeaconControllerAPI.updateUsingPATCH1WithRequestBuilder(batteryLevelUpdate: battery, id: id).addCredential().execute { (response, error) in
                                        do {
                                            let batteryLevelInfos = try self.managedContext.fetch(fetchRequest)
                                            
                                            if let batteryLevelInfo = batteryLevelInfos.first {
                                                batteryLevelInfo.setValue(dateNow.timeIntervalSince1970, forKey: "lastSent")
                                            }
                                            try self.managedContext.save()
                                        } catch let error as NSError {
                                            NSLog("Could not fetch. \(error), \(error.userInfo)")
                                        }
                                    }
                                }
                            } catch let error as NSError {
                                NSLog("Could not fetch. \(error), \(error.userInfo)")
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc
    public func refreshBeacons(completionHandler: @escaping (_ result: Int) -> Void) {
        let fetchRequest:NSFetchRequest<BeaconInfoSDK> = BeaconInfoSDK.fetchRequest()
        fetchRequest.fetchLimit = 1
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        var latestUpdatedAt : Int64 = 0
        do {
            let newestInfos = (try managedContext.fetch(fetchRequest) as [BeaconInfoSDK]?)
            let newestInfo = newestInfos?.first
            if (newestInfo != nil) {
                latestUpdatedAt = newestInfo!.updatedAt
            }
        } catch {
            completionHandler(-1)
        }
        InfoControllerAPI.getListUsingGET2(updatedAfter: latestUpdatedAt) { (infos: [Info]?, error: Error?) in
            if (infos != nil) {
                for info in infos! {
                    self.save(info: info)
                }
                completionHandler(infos!.count)
                UserDefaults.standard.set(Date(), forKey: self.LAST_REFRESH)
            }
            else {
                completionHandler(-1)
            }
        }
    }
    
    func discoveredIBeaconByCache(iBeacon: CLBeacon, beaconInfo: BeaconInfoSDK) {
        delegate?.didDiscoverIBeacon(IBeacon(uuid: iBeacon.proximityUUID.uuidString,
                                             major: Int32(truncating: iBeacon.major),
                                             minor: Int32(truncating: iBeacon.minor),
                                             info: BZBeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo)))
    }
    
    func discoveredEddystoneByCache(eddystone: KTKEddystone, beaconInfo: BeaconInfoSDK) {
        delegate?.didDiscoverEddystone(Eddystone(namespace: eddystone.eddystoneUID?.namespaceID,
                                                 instanceId: eddystone.eddystoneUID?.instanceID,
                                                 url: eddystone.eddystoneURL?.url?.absoluteString,
                                                 eid: nil,
                                                 encryptedTelemetry: nil,
                                                 batteryVoltage: eddystone.eddystoneTLM?.batteryVoltage,
                                                 temperature:eddystone.eddystoneTLM?.temperature,
                                                 info: BZBeaconInfo.fromBeaconInfoSDK(beaconInfo: beaconInfo)))
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
        beacon.setValue(info.updatedAt, forKeyPath:"updatedAt")
        beacon.setValue(info.uuid?.uuidString, forKeyPath: "uuid")
        beacon.setValue(info.website, forKeyPath: "website")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            NSLog("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    public func beaconManager(_ manager: KTKBeaconManager, didDetermineState state: CLRegionState, for region: KTKBeaconRegion) {
        switch state {
        case .inside:
            beaconManager.startRangingBeacons(in: region)
        default:
            break
        }
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
