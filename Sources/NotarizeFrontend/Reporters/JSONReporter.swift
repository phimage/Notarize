//
//  JSONReporter.swift
//
//  Created by phimage on 28/07/2019.
//

import Foundation
import NotarizationInfo
import NotarizeProcess

struct JSONReporter: Reporter {

    static let identifier = "json"

    static func generateReport(info: NotarizationInfo) -> String {
        return generateReport(encodable: info)
    }

    static func generateReport(history: NotarizationHistory) -> String {
        return generateReport(encodable: history)
    }

    static func generateReport<E: Encodable>(encodable: E) -> String {
        guard let data = try? JSONEncoder().encode(encodable) else {
            return ""
        }
        return String(data: data, encoding: .utf8) ?? ""
    }

    static func generateReport(error: Error) -> String {
        if let error = error as? NotarizeProcessError {
            switch error {
            case .notaryError(let notarizationError):
                return generateReport(encodable: notarizationError)
            case .processError:
                return "\(error)"
            case .decodingError:
                return "\(error)"
            case .timeOut:
                return "\(error)"
            }
        }
        return "\(error)"
    }
}
