//
// Resource.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class Resource: Codable {

    public var description: String?
    public var file: File?
    public var filename: String?
    public var inputStream: InputStream?
    public var open: Bool?
    public var readable: Bool?
    public var uri: URI?
    public var url: ModelURL?


    
    public init(description: String?, file: File?, filename: String?, inputStream: InputStream?, open: Bool?, readable: Bool?, uri: URI?, url: ModelURL?) {
        self.description = description
        self.file = file
        self.filename = filename
        self.inputStream = inputStream
        self.open = open
        self.readable = readable
        self.uri = uri
        self.url = url
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encodeIfPresent(description, forKey: "description")
        try container.encodeIfPresent(file, forKey: "file")
        try container.encodeIfPresent(filename, forKey: "filename")
        try container.encodeIfPresent(inputStream, forKey: "inputStream")
        try container.encodeIfPresent(open, forKey: "open")
        try container.encodeIfPresent(readable, forKey: "readable")
        try container.encodeIfPresent(uri, forKey: "uri")
        try container.encodeIfPresent(url, forKey: "url")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        description = try container.decodeIfPresent(String.self, forKey: "description")
        file = try container.decodeIfPresent(File.self, forKey: "file")
        filename = try container.decodeIfPresent(String.self, forKey: "filename")
        inputStream = try container.decodeIfPresent(InputStream.self, forKey: "inputStream")
        open = try container.decodeIfPresent(Bool.self, forKey: "open")
        readable = try container.decodeIfPresent(Bool.self, forKey: "readable")
        uri = try container.decodeIfPresent(URI.self, forKey: "uri")
        url = try container.decodeIfPresent(ModelURL.self, forKey: "url")
    }
}
