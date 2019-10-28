//
//  HistoryCommand.swift
//  
//
//  Created by phimage on 24/10/2019.
//

import Foundation

import Commandant
import PathKit

import NotarizeProcess

struct HistoryCommand: CommandProtocol {
    typealias Options = HistoryOptions
    typealias ClientError = Options.ClientError

    let verb: String = "history"
    var function: String = "Show history"
    let reporter: String? = nil

    func run(_ options: HistoryCommand.Options) -> Result<(), HistoryCommand.ClientError> {
        let config = Config(options: options) ?? Config.default

        guard let username = options.username ?? config.username else {
            fatalError("No username specified using --username or configuration file.")
        }
        guard let password = options.password ?? config.password else {
            fatalError("No password specified using --password or configuration file.")
        }
        let ascProvider = options.ascProvider ?? config.ascProvider
        let page = options.page ?? 0

        let reporter = Reporters.reporter(from: options.reporter ?? config.reporter)
        let process = NotarizeProcess(username: username, password: password, ascProvider: ascProvider)

        do {
            let history = try process.notarizationHistory(for: page)
            let output = reporter.generateReport(history: history)
            print(output)
            return .success(())
        } catch {
            let output = reporter.generateReport(error: error)
            print(output)
            exit(1)
        }
    }
}

struct HistoryOptions: OptionsProtocol {
    typealias ClientError = CommandantError<()>

    let page: Int?
    let username: String?
    let password: String?
    let ascProvider: String?
    let reporter: String?
    let configurationFile: String?

    static func create(_ page: Int?) -> (_ username: String?) -> (_ password: String?) -> (_ ascProvider: String?) -> (_ reporter: String?) -> (_ config: String?) -> HistoryOptions {
        return { username in
            return { password in
                return { ascProvider in
                    return { reporter in
                        return { config in
                            self.init(page: page, username: username, password: password, ascProvider: ascProvider, reporter: reporter, configurationFile: config)
                        }
                    }
                }
            }
        }
    }

    static let passwordExplanation = "Entering in plaintext or it may also be specified using a '@keychain: or '@env:' prefix followed by a keychain password item name or environment variable name"
    static func evaluate(_ mode: CommandMode) -> Result<HistoryCommand.Options, CommandantError<HistoryOptions.ClientError>> {
        return create
            <*> mode <| Option(key: "page", defaultValue: nil, usage: "The history page to display")
            <*> mode <| Option(key: "username", defaultValue: nil, usage: "Username. Required to connect for validation, upload, and notarization.")
            <*> mode <| Option(key: "password", defaultValue: nil, usage: "Password. Required. \(NotarizeOptions.passwordExplanation).'")
            <*> mode <| Option(key: "ascProvider", defaultValue: nil, usage: "Required when a user account is associated with multiple providers.")
            <*> mode <| Option(key: "reporter", defaultValue: nil, usage: "the reporter used to show notarization history information")
            <*> mode <| Option(key: "config", defaultValue: nil, usage: "the path to notarize configuration file")
    }
}

extension Config {
    init?(options: HistoryOptions) {
        if let configurationFile = options.configurationFile {
            let configurationURL = URL(fileURLWithPath: configurationFile)
            try? self.init(url: configurationURL)
        } else {
            let workDirectoryString = FileManager.default.currentDirectoryPath
            let workDirectory = URL(fileURLWithPath: workDirectoryString)
            try? self.init(directoryURL: workDirectory)
        }
    }
}
