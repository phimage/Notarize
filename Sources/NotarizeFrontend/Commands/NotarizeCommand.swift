//
//  NotarizeCommand.swift
//  
//
//  Created by phimage on 24/10/2019.
//

import Foundation

import Commandant
import PathKit

import NotarizeProcess

struct NotarizeCommand: CommandProtocol {
    typealias Options = NotarizeOptions
    typealias ClientError = Options.ClientError

    let verb: String = "notarize"
    var function: String = "Notarize (default command)"
    let reporter: String? = nil

    func run(_ options: NotarizeCommand.Options) -> Result<(), NotarizeCommand.ClientError> {
        guard let appPath = options.path else {
            fatalError("You must specify application path with --app.")
        }
        guard FileManager.default.fileExists(atPath: appPath) else {
            fatalError("\(appPath) not exists.")
        }
        let appURL = URL(fileURLWithPath: appPath)

        let config = Config(options: options) ?? Config.default

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
            if let info = try process.run(on: appURL) {
                let output = reporter.generateReport(info: info)
                print(output)
            }
            return .success(())
        } catch {
            let output = reporter.generateReport(error: error)
            print(output)
            exit(1)
        }
    }
}

struct NotarizeOptions: OptionsProtocol {
    typealias ClientError = CommandantError<()>

    let path: String?
    let username: String?
    let password: String?
    let ascProvider: String?
    let reporter: String?
    let configurationFile: String?

    static func create(_ path: String?) -> (_ username: String?) -> (_ password: String?) -> (_ ascProvider: String?) -> (_ reporter: String?) -> (_ config: String?) -> NotarizeOptions {
        return { username in
            return { password in
                return { ascProvider in
                    return { reporter in
                        return { config in
                            self.init(path: path, username: username, password: password, ascProvider: ascProvider, reporter: reporter, configurationFile: config)
                        }
                    }
                }
            }
        }
    }

    static let passwordExplanation = "Entering in plaintext or it may also be specified using a '@keychain: or '@env:' prefix followed by a keychain password item name or environment variable name"
    static func evaluate(_ mode: CommandMode) -> Result<NotarizeCommand.Options, CommandantError<NotarizeOptions.ClientError>> {
        return create
            <*> mode <| Option(key: "app", defaultValue: nil, usage: "the app to notarize")
            <*> mode <| Option(key: "username", defaultValue: nil, usage: "Username. Required to connect for validation, upload, and notarization.")
            <*> mode <| Option(key: "password", defaultValue: nil, usage: "Password. Required. \(NotarizeOptions.passwordExplanation).'")
            <*> mode <| Option(key: "ascProvider", defaultValue: nil, usage: "Required when a user account is associated with multiple providers.")
            <*> mode <| Option(key: "reporter", defaultValue: nil, usage: "the reporter used to show notarization information")
            <*> mode <| Option(key: "config", defaultValue: nil, usage: "the path to notarize configuration file")
    }
}

extension Config {
    init?(options: NotarizeOptions) {
        if let configurationFile = options.configurationFile {
            let configurationURL = URL(fileURLWithPath: configurationFile)
            try? self.init(url: configurationURL)
        } else {
            let workDirectoryString = options.path ?? FileManager.default.currentDirectoryPath
            let workDirectory = URL(fileURLWithPath: workDirectoryString)
            try? self.init(directoryURL: workDirectory)
        }
    }
}
