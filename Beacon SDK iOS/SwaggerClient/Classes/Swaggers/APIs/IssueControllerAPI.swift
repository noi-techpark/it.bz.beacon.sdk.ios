// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

//
// IssueControllerAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class IssueControllerAPI {
    /**
     Create a issue
     
     - parameter issueCreation: (body) issueCreation 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createUsingPOST2(issueCreation: IssueCreation, completion: @escaping ((_ data: BeaconIssue?,_ error: Error?) -> Void)) {
        createUsingPOST2WithRequestBuilder(issueCreation: issueCreation).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Create a issue
     - POST /v1/admin/issues
     - API Key:
       - type: apiKey Authorization 
       - name: JWT
     - examples: [{contentType=application/json, example={
  "resolver" : "resolver",
  "beacon" : {
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
  },
  "problem" : "problem",
  "reportDate" : 6,
  "resolveDate" : 1,
  "solution" : "solution",
  "solutionDescription" : "solutionDescription",
  "problemDescription" : "problemDescription",
  "reporter" : "reporter",
  "id" : 0,
  "resolved" : true
}}]
     
     - parameter issueCreation: (body) issueCreation 

     - returns: RequestBuilder<BeaconIssue> 
     */
    open class func createUsingPOST2WithRequestBuilder(issueCreation: IssueCreation) -> RequestBuilder<BeaconIssue> {
        let path = "/v1/admin/issues"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: issueCreation)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<BeaconIssue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     View a list of available issues
     
     - parameter onlyUnresolved: (query) onlyUnresolved (optional, default to false)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getListUsingGET3(onlyUnresolved: Bool? = nil, completion: @escaping ((_ data: [BeaconIssue]?,_ error: Error?) -> Void)) {
        getListUsingGET3WithRequestBuilder(onlyUnresolved: onlyUnresolved).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     View a list of available issues
     - GET /v1/admin/issues
     - API Key:
       - type: apiKey Authorization 
       - name: JWT
     - examples: [{contentType=application/json, example=[ {
  "resolver" : "resolver",
  "beacon" : {
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
  },
  "problem" : "problem",
  "reportDate" : 6,
  "resolveDate" : 1,
  "solution" : "solution",
  "solutionDescription" : "solutionDescription",
  "problemDescription" : "problemDescription",
  "reporter" : "reporter",
  "id" : 0,
  "resolved" : true
}, {
  "resolver" : "resolver",
  "beacon" : {
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
  },
  "problem" : "problem",
  "reportDate" : 6,
  "resolveDate" : 1,
  "solution" : "solution",
  "solutionDescription" : "solutionDescription",
  "problemDescription" : "problemDescription",
  "reporter" : "reporter",
  "id" : 0,
  "resolved" : true
} ]}]
     
     - parameter onlyUnresolved: (query) onlyUnresolved (optional, default to false)

     - returns: RequestBuilder<[BeaconIssue]> 
     */
    open class func getListUsingGET3WithRequestBuilder(onlyUnresolved: Bool? = nil) -> RequestBuilder<[BeaconIssue]> {
        let path = "/v1/admin/issues"
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "onlyUnresolved": onlyUnresolved
        ])
        

        let requestBuilder: RequestBuilder<[BeaconIssue]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     View a list of available issues for the specified beacon ID
     
     - parameter beaconId: (path) beaconId 
     - parameter onlyUnresolved: (query) onlyUnresolved (optional, default to false)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getListUsingGET4(beaconId: String, onlyUnresolved: Bool? = nil, completion: @escaping ((_ data: [BeaconIssue]?,_ error: Error?) -> Void)) {
        getListUsingGET4WithRequestBuilder(beaconId: beaconId, onlyUnresolved: onlyUnresolved).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     View a list of available issues for the specified beacon ID
     - GET /v1/admin/beacons/{beaconId}/issues
     - API Key:
       - type: apiKey Authorization 
       - name: JWT
     - examples: [{contentType=application/json, example=[ {
  "resolver" : "resolver",
  "beacon" : {
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
  },
  "problem" : "problem",
  "reportDate" : 6,
  "resolveDate" : 1,
  "solution" : "solution",
  "solutionDescription" : "solutionDescription",
  "problemDescription" : "problemDescription",
  "reporter" : "reporter",
  "id" : 0,
  "resolved" : true
}, {
  "resolver" : "resolver",
  "beacon" : {
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
  },
  "problem" : "problem",
  "reportDate" : 6,
  "resolveDate" : 1,
  "solution" : "solution",
  "solutionDescription" : "solutionDescription",
  "problemDescription" : "problemDescription",
  "reporter" : "reporter",
  "id" : 0,
  "resolved" : true
} ]}]
     
     - parameter beaconId: (path) beaconId 
     - parameter onlyUnresolved: (query) onlyUnresolved (optional, default to false)

     - returns: RequestBuilder<[BeaconIssue]> 
     */
    open class func getListUsingGET4WithRequestBuilder(beaconId: String, onlyUnresolved: Bool? = nil) -> RequestBuilder<[BeaconIssue]> {
        var path = "/v1/admin/beacons/{beaconId}/issues"
        path = path.replacingOccurrences(of: "{beaconId}", with: "\(beaconId)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems(values:[
            "onlyUnresolved": onlyUnresolved
        ])
        

        let requestBuilder: RequestBuilder<[BeaconIssue]>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Search a issue with an ID
     
     - parameter id: (path) id 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getUsingGET2(id: Int64, completion: @escaping ((_ data: BeaconIssue?,_ error: Error?) -> Void)) {
        getUsingGET2WithRequestBuilder(id: id).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Search a issue with an ID
     - GET /v1/admin/issues/{id}
     - API Key:
       - type: apiKey Authorization 
       - name: JWT
     - examples: [{contentType=application/json, example={
  "resolver" : "resolver",
  "beacon" : {
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
  },
  "problem" : "problem",
  "reportDate" : 6,
  "resolveDate" : 1,
  "solution" : "solution",
  "solutionDescription" : "solutionDescription",
  "problemDescription" : "problemDescription",
  "reporter" : "reporter",
  "id" : 0,
  "resolved" : true
}}]
     
     - parameter id: (path) id 

     - returns: RequestBuilder<BeaconIssue> 
     */
    open class func getUsingGET2WithRequestBuilder(id: Int64) -> RequestBuilder<BeaconIssue> {
        var path = "/v1/admin/issues/{id}"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters: [String:Any]? = nil

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<BeaconIssue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update a issue
     
     - parameter id: (path) id 
     - parameter issueSolution: (body) issueSolution 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateUsingPOST(id: Int64, issueSolution: IssueSolution, completion: @escaping ((_ data: BeaconIssue?,_ error: Error?) -> Void)) {
        updateUsingPOSTWithRequestBuilder(id: id, issueSolution: issueSolution).execute { (response, error) -> Void in
            completion(response?.body, error);
        }
    }


    /**
     Update a issue
     - POST /v1/admin/issues/{id}/resolve
     - API Key:
       - type: apiKey Authorization 
       - name: JWT
     - examples: [{contentType=application/json, example={
  "resolver" : "resolver",
  "beacon" : {
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
  },
  "problem" : "problem",
  "reportDate" : 6,
  "resolveDate" : 1,
  "solution" : "solution",
  "solutionDescription" : "solutionDescription",
  "problemDescription" : "problemDescription",
  "reporter" : "reporter",
  "id" : 0,
  "resolved" : true
}}]
     
     - parameter id: (path) id 
     - parameter issueSolution: (body) issueSolution 

     - returns: RequestBuilder<BeaconIssue> 
     */
    open class func updateUsingPOSTWithRequestBuilder(id: Int64, issueSolution: IssueSolution) -> RequestBuilder<BeaconIssue> {
        var path = "/v1/admin/issues/{id}/resolve"
        path = path.replacingOccurrences(of: "{id}", with: "\(id)", options: .literal, range: nil)
        let URLString = SwaggerClientAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: issueSolution)

        let url = NSURLComponents(string: URLString)


        let requestBuilder: RequestBuilder<BeaconIssue>.Type = SwaggerClientAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
