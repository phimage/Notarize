//
//  File.swift
//  
//
//  Created by phimage on 24/10/2019.
//

import Foundation
import Yams

public struct Config: Codable {

    public let username: String?
    public let password: String?
    public let ascProvider: String?
    public let reporter: String

    enum CodingKeys: String, CodingKey {
        case username
        case password
        case ascProvider
        case reporter
    }

    public static let fileName = ".notarize.yml"
    public static let `default` = Config.init()
    public static let defaultReporter = "json"

    private init() {
        self.username = nil
        self.password = nil
        self.ascProvider = nil
        reporter = Config.defaultReporter
    }

    init(username: String, password: String, ascProvider: String? = nil, reporter: String = Config.defaultReporter) {
        self.username = username
        self.password = password
        self.ascProvider = ascProvider
        self.reporter = reporter
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decodeIfPresent(String.self, forKey: .username)
        password = try container.decodeIfPresent(String.self, forKey: .password)
        ascProvider = try container.decodeIfPresent(String.self, forKey: .ascProvider)
        reporter = try container.decodeIfPresent(String.self, forKey: .reporter) ?? Config.defaultReporter
    }

    public init(url: URL) throws {
        self = try YAMLDecoder().decode(from: String.init(contentsOf: url))
    }

    public init(directoryURL: URL, fileName: String = fileName) throws {
        let url = directoryURL.appendingPathComponent(fileName)
        try self.init(url: url)
    }
}
