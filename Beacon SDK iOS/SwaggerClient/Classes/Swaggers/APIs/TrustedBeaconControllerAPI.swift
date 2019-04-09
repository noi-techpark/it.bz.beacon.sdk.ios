//
// TrustedBeaconControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class TrustedBeaconControllerAPI {
    /**
     Update battery level of beacon
     
     - parameter batteryLevelUpdate: (body) batteryLevelUpdate 
     - parameter id: (path) id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateUsingPATCH1(batteryLevelUpdate: BeaconBatteryLevelUpdate, id: String, completion: @escaping ((_ data: Beacon?,_ error: Error?) -> Void)) {
        updateUsingPATCH1WithRequestBuilder(batteryLevelUpdate: batteryLevelUpdate, id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Update battery level of beacon
     - PATCH /v1/trusted/beacons/{id}/batteryLevel
     - BASIC:
       - type: basic
       - name: TrustedAuth
     - examples: [{contentType=application/json, example={
  "minor" : 7,
  "iBeacon" : true,
  "locationDescription" : "locationDescription",
  "description" : "description",
  "locationType" : "OUTDOOR",
  "eddystoneUid" : true,
  "uuid" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
  "manufacturer" : "KONTAKT_IO",
  "eddystoneTlm" : true,
  "internalName" : "internalName",
  "txPower" : 7,
  "instanceId" : "instanceId",
  "major" : 2,
  "eddystoneEid" : true,
  "id" : "id",
  "lat" : 5.962134,
  "batteryLevel" : 0,
  "eddystoneEtlm" : true,
  "lng" : 5.637377,
  "pendingConfiguration" : {
    "eddystoneEtlm" : true,
    "minor" : 2,
    "iBeacon" : true,
    "eddystoneUid" : true,
    "eddystoneUrl" : true,
    "uuid" : "046b6c7f-0b8a-43b9-b35d-6489e6daee91",
    "url" : "url",
    "eddystoneTlm" : true,
    "txPower" : 4,
    "instanceId" : "instanceId",
    "major" : 3,
    "namespace" : "namespace",
    "eddystoneEid" : true,
    "interval" : 9,
    "telemetry" : true
  },
  "manufacturerId" : "manufacturerId",
  "eddystoneUrl" : true,
  "url" : "url",
  "lastSeen" : 1,
  "name" : "name",
  "namespace" : "namespace",
  "interval" : 6,
  "telemetry" : true,
  "status" : "OK"
}}]
     
     - parameter batteryLevelUpdate: (body) batteryLevelUpdate 
     - parameter id: (path) id 

     - returns: RequestBuilder<Beacon> 
     */
    open class func updateUsingPATCH1WithRequestBuilder(batteryLevelUpdate: BeaconBatteryLevelUpdate, id: String) -> RequestBuilder<Beacon> {
        var path = "/v1/trusted/beacons/{id}/batteryLevel"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: batteryLevelUpdate)

        let url = NSURLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Beacon>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PATCH", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
