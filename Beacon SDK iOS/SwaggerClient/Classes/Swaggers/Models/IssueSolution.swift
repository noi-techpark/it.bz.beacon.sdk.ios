//
// IssueSolution.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



open class IssueSolution: Codable {

    public var resolver: String
    public var solution: String
    public var solutionDescription: String?


    
    public init(resolver: String, solution: String, solutionDescription: String?) {
        self.resolver = resolver
        self.solution = solution
        self.solutionDescription = solutionDescription
    }
    

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {

        var container = encoder.container(keyedBy: String.self)

        try container.encode(resolver, forKey: "resolver")
        try container.encode(solution, forKey: "solution")
        try container.encodeIfPresent(solutionDescription, forKey: "solutionDescription")
    }

    // Decodable protocol methods

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: String.self)

        resolver = try container.decode(String.self, forKey: "resolver")
        solution = try container.decode(String.self, forKey: "solution")
        solutionDescription = try container.decodeIfPresent(String.self, forKey: "solutionDescription")
    }
}
