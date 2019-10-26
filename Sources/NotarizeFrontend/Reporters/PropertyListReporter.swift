//
//  PropertyListReporter.swift
//
//  Created by phimage on 28/07/2019.
//

import Foundation
import NotarizationInfo

struct PropertyListReporter: Reporter {

    static let identifier = "xml"

    static func generateReport(info: NotarizationInfo) -> String {
        return generateReport(encodable: info)
    }

    static func generateReport(history: NotarizationHistory) -> String {
        return generateReport(encodable: history)
    }

    static func generateReport<E: Encodable>(encodable: E) -> String {
        guard let data = try? PropertyListEncoder().encode(encodable) else {
            return ""
        }
        return String(data: data, encoding: .utf8)!
    }
}
