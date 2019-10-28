//
//  InfoCommand.swift
//  
//
//  Created by phimage on 24/10/2019.
//

import Foundation

import Commandant
import PathKit

import NotarizeProcess

struct InfoCommand: CommandProtocol {
    typealias Options = InfoOptions
    typealias ClientError = Options.ClientError

    let verb: String = "info"
    var function: String = "Show information"
    let reporter: String? = nil

    func run(_ options: InfoCommand.Options) -> Result<(), InfoCommand.ClientError> {
        let config = Config(options: options) ?? Config.default
        guard let uuid = options.uuid else {
            fatalError("No uuid specified using --uuid")
        }
        guard let username = options.username ?? config.username else {
            fatalError("No username specified using --username or configuration file.")
        }
        guard let password = options.password ?? config.password else {
            fatalError("No password specified using --password or configuration file.")
        }
        let ascProvider = options.ascProvider ?? config.ascProvider

        let reporter = Reporters.reporter(from: options.reporter ?? config.reporter)
        let process = NotarizeProcess(username: username, password: password, ascProvider: ascProvider)

        do {
            let info = try process.notarizationInfo(for: uuid)
            let output = reporter.generateReport(info: info)
            print(output)
            return .success(())
        } catch {
            let output = reporter.generateReport(error: error)
            print(output)
            exit(1)
        }
    }
}

struct InfoOptions: OptionsProtocol {
    typealias ClientError = CommandantError<()>

    let uuid: String?
    let username: String?
    let password: String?
    let ascProvider: String?
    let reporter: String?
    let configurationFile: String?

    static func create(_ uuid: String?) -> (_ username: String?) -> (_ password: String?) -> (_ ascProvider: String?) -> (_ reporter: String?) -> (_ config: String?) -> InfoOptions {
        return { username in
            return { password in
                return { ascProvider in
                    return { reporter in
                        return { config in
                            self.init(uuid: uuid, username: username, password: password, ascProvider: ascProvider, reporter: reporter, configurationFile: config)
                        }
                    }
                }
            }
        }
    }

    static let passwordExplanation = "Entering in plaintext or it may also be specified using a '@keychain: or '@env:' prefix followed by a keychain password item name or environment variable name"
    static func evaluate(_ mode: CommandMode) -> Result<InfoCommand.Options, CommandantError<InfoOptions.ClientError>> {
        return create
            <*> mode <| Option(key: "uuid", defaultValue: nil, usage: "The notarization uuid to get information")
            <*> mode <| Option(key: "username", defaultValue: nil, usage: "Username. Required to connect for validation, upload, and notarization.")
            <*> mode <| Option(key: "password", defaultValue: nil, usage: "Password. Required. \(NotarizeOptions.passwordExplanation).'")
            <*> mode <| Option(key: "ascProvider", defaultValue: nil, usage: "Required when a user account is associated with multiple providers.")
            <*> mode <| Option(key: "reporter", defaultValue: nil, usage: "the reporter used to show notarization Info information")
            <*> mode <| Option(key: "config", defaultValue: nil, usage: "the path to notarize configuration file")
    }
}

extension Config {
    init?(options: InfoOptions) {
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
