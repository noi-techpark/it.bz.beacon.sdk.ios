// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

//
// User.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class User: Codable {

    public var admin: Bool?
    public var email: String?
    public var id: Int64?
    public var name: String?
    public var surname: String?
    public var username: String?


    
    public init(admin: Bool?, email: String?, id: Int64?, name: String?, surname: String?, username: String?) {
        self.admin = admin
        self.email = email
        self.id = id
        self.name = name
        self.surname = surname
        self.username = username
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(admin, forKey: "admin")
        try container.encodeIfPresent(email, forKey: "email")
        try container.encodeIfPresent(id, forKey: "id")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(surname, forKey: "surname")
        try container.encodeIfPresent(username, forKey: "username")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        admin = try container.decodeIfPresent(Bool.self, forKey: "admin")
        email = try container.decodeIfPresent(String.self, forKey: "email")
        id = try container.decodeIfPresent(Int64.self, forKey: "id")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        surname = try container.decodeIfPresent(String.self, forKey: "surname")
        username = try container.decodeIfPresent(String.self, forKey: "username")
    }
}

