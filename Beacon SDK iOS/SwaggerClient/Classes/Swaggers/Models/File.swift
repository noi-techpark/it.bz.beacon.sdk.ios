// SPDX-FileCopyrightText: NOI Techpark <digital@noi.bz.it>
//
// SPDX-License-Identifier: AGPL-3.0-or-later

//
// File.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class File: Codable {

    public var absolute: Bool?
    public var absoluteFile: File?
    public var absolutePath: String?
    public var canonicalFile: File?
    public var canonicalPath: String?
    public var directory: Bool?
    public var file: Bool?
    public var freeSpace: Int64?
    public var hidden: Bool?
    public var name: String?
    public var parent: String?
    public var parentFile: File?
    public var path: String?
    public var totalSpace: Int64?
    public var usableSpace: Int64?


    
    public init(absolute: Bool?, absoluteFile: File?, absolutePath: String?, canonicalFile: File?, canonicalPath: String?, directory: Bool?, file: Bool?, freeSpace: Int64?, hidden: Bool?, name: String?, parent: String?, parentFile: File?, path: String?, totalSpace: Int64?, usableSpace: Int64?) {
        self.absolute = absolute
        self.absoluteFile = absoluteFile
        self.absolutePath = absolutePath
        self.canonicalFile = canonicalFile
        self.canonicalPath = canonicalPath
        self.directory = directory
        self.file = file
        self.freeSpace = freeSpace
        self.hidden = hidden
        self.name = name
        self.parent = parent
        self.parentFile = parentFile
        self.path = path
        self.totalSpace = totalSpace
        self.usableSpace = usableSpace
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(absolute, forKey: "absolute")
        try container.encodeIfPresent(absoluteFile, forKey: "absoluteFile")
        try container.encodeIfPresent(absolutePath, forKey: "absolutePath")
        try container.encodeIfPresent(canonicalFile, forKey: "canonicalFile")
        try container.encodeIfPresent(canonicalPath, forKey: "canonicalPath")
        try container.encodeIfPresent(directory, forKey: "directory")
        try container.encodeIfPresent(file, forKey: "file")
        try container.encodeIfPresent(freeSpace, forKey: "freeSpace")
        try container.encodeIfPresent(hidden, forKey: "hidden")
        try container.encodeIfPresent(name, forKey: "name")
        try container.encodeIfPresent(parent, forKey: "parent")
        try container.encodeIfPresent(parentFile, forKey: "parentFile")
        try container.encodeIfPresent(path, forKey: "path")
        try container.encodeIfPresent(totalSpace, forKey: "totalSpace")
        try container.encodeIfPresent(usableSpace, forKey: "usableSpace")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        absolute = try container.decodeIfPresent(Bool.self, forKey: "absolute")
        absoluteFile = try container.decodeIfPresent(File.self, forKey: "absoluteFile")
        absolutePath = try container.decodeIfPresent(String.self, forKey: "absolutePath")
        canonicalFile = try container.decodeIfPresent(File.self, forKey: "canonicalFile")
        canonicalPath = try container.decodeIfPresent(String.self, forKey: "canonicalPath")
        directory = try container.decodeIfPresent(Bool.self, forKey: "directory")
        file = try container.decodeIfPresent(Bool.self, forKey: "file")
        freeSpace = try container.decodeIfPresent(Int64.self, forKey: "freeSpace")
        hidden = try container.decodeIfPresent(Bool.self, forKey: "hidden")
        name = try container.decodeIfPresent(String.self, forKey: "name")
        parent = try container.decodeIfPresent(String.self, forKey: "parent")
        parentFile = try container.decodeIfPresent(File.self, forKey: "parentFile")
        path = try container.decodeIfPresent(String.self, forKey: "path")
        totalSpace = try container.decodeIfPresent(Int64.self, forKey: "totalSpace")
        usableSpace = try container.decodeIfPresent(Int64.self, forKey: "usableSpace")
    }
}

