//
//  File.swift
//  
//
//  Created by phimage on 24/10/2019.
//

import Foundation
import Commandant

struct VersionCommand: CommandProtocol {
    let verb = "version"
    let function = "Display the current version of notarize"

    func run(_ options: NoOptions<CommandantError<()>>) -> Result<(), CommandantError<()>> {
        print(Version.current.value)
        return .success(())
    }
}
