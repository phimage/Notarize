//
//  Reporter.swift
//  IBGraphKit
//
//  Created by phimage on 28/07/2019.
//

import NotarizationInfo

public protocol Reporter {
    static var identifier: String { get }

    static func generateReport(info: NotarizationInfo) -> String
    static func generateReport(history: NotarizationHistory) -> String
    static func generateReport(error: Error) -> String
}

extension Reporter {
    static func generateReport(error: Error) -> String {
        return "\(error)"
    }
}

public struct Reporters {

    public static func reporter(from reporter: String) -> Reporter.Type {
        switch reporter {
        case JSONReporter.identifier:
            return JSONReporter.self
        case PropertyListReporter.identifier:
            return PropertyListReporter.self
        default:
            fatalError("no reporter with identifier '\(reporter) available'")
        }
    }
}
