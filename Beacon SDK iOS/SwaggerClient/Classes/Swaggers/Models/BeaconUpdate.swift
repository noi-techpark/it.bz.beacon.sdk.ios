// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

//
// BeaconUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class BeaconUpdate: Codable {

    public enum LocationType: String, Codable { 
        case outdoor = "OUTDOOR"
        case indoor = "INDOOR"
    }
    public var description: String
    public var eddystoneEid: Bool
    public var eddystoneEtlm: Bool
    public var eddystoneTlm: Bool
    public var eddystoneUid: Bool
    public var eddystoneUrl: Bool
    public var iBeacon: Bool
    public var instanceId: String
    public var interval: Int
    public var lat: Float
    public var lng: Float
    public var locationDescription: String
    public var locationType: LocationType
    public var major: Int
    public var minor: Int
    public var name: String
    public var namespace: String
    public var telemetry: Bool
    public var txPower: Int
    public var url: String
    public var uuid: UUID


    
    public init(description: String, eddystoneEid: Bool, eddystoneEtlm: Bool, eddystoneTlm: Bool, eddystoneUid: Bool, eddystoneUrl: Bool, iBeacon: Bool, instanceId: String, interval: Int, lat: Float, lng: Float, locationDescription: String, locationType: LocationType, major: Int, minor: Int, name: String, namespace: String, telemetry: Bool, txPower: Int, url: String, uuid: UUID) {
        self.description = description
        self.eddystoneEid = eddystoneEid
        self.eddystoneEtlm = eddystoneEtlm
        self.eddystoneTlm = eddystoneTlm
        self.eddystoneUid = eddystoneUid
        self.eddystoneUrl = eddystoneUrl
        self.iBeacon = iBeacon
        self.instanceId = instanceId
        self.interval = interval
        self.lat = lat
        self.lng = lng
        self.locationDescription = locationDescription
        self.locationType = locationType
        self.major = major
        self.minor = minor
        self.name = name
        self.namespace = namespace
        self.telemetry = telemetry
        self.txPower = txPower
        self.url = url
        self.uuid = uuid
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(description, forKey: "description")
        try container.encode(eddystoneEid, forKey: "eddystoneEid")
        try container.encode(eddystoneEtlm, forKey: "eddystoneEtlm")
        try container.encode(eddystoneTlm, forKey: "eddystoneTlm")
        try container.encode(eddystoneUid, forKey: "eddystoneUid")
        try container.encode(eddystoneUrl, forKey: "eddystoneUrl")
        try container.encode(iBeacon, forKey: "iBeacon")
        try container.encode(instanceId, forKey: "instanceId")
        try container.encode(interval, forKey: "interval")
        try container.encode(lat, forKey: "lat")
        try container.encode(lng, forKey: "lng")
        try container.encode(locationDescription, forKey: "locationDescription")
        try container.encode(locationType, forKey: "locationType")
        try container.encode(major, forKey: "major")
        try container.encode(minor, forKey: "minor")
        try container.encode(name, forKey: "name")
        try container.encode(namespace, forKey: "namespace")
        try container.encode(telemetry, forKey: "telemetry")
        try container.encode(txPower, forKey: "txPower")
        try container.encode(url, forKey: "url")
        try container.encode(uuid, forKey: "uuid")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        description = try container.decode(String.self, forKey: "description")
        eddystoneEid = try container.decode(Bool.self, forKey: "eddystoneEid")
        eddystoneEtlm = try container.decode(Bool.self, forKey: "eddystoneEtlm")
        eddystoneTlm = try container.decode(Bool.self, forKey: "eddystoneTlm")
        eddystoneUid = try container.decode(Bool.self, forKey: "eddystoneUid")
        eddystoneUrl = try container.decode(Bool.self, forKey: "eddystoneUrl")
        iBeacon = try container.decode(Bool.self, forKey: "iBeacon")
        instanceId = try container.decode(String.self, forKey: "instanceId")
        interval = try container.decode(Int.self, forKey: "interval")
        lat = try container.decode(Float.self, forKey: "lat")
        lng = try container.decode(Float.self, forKey: "lng")
        locationDescription = try container.decode(String.self, forKey: "locationDescription")
        locationType = try container.decode(LocationType.self, forKey: "locationType")
        major = try container.decode(Int.self, forKey: "major")
        minor = try container.decode(Int.self, forKey: "minor")
        name = try container.decode(String.self, forKey: "name")
        namespace = try container.decode(String.self, forKey: "namespace")
        telemetry = try container.decode(Bool.self, forKey: "telemetry")
        txPower = try container.decode(Int.self, forKey: "txPower")
        url = try container.decode(String.self, forKey: "url")
        uuid = try container.decode(UUID.self, forKey: "uuid")
    }
}

