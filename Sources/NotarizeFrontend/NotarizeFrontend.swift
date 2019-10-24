import Foundation
import Commandant

public struct NotarizeFrontend {

    public init() {}

    public func run() {
        let registry = CommandRegistry<CommandantError<()>>()
        registry.register(NotarizeCommand())
        registry.register(HelpCommand(registry: registry))
        registry.register(VersionCommand())

        registry.main(defaultVerb: NotarizeCommand().verb) { (error) in
            print(String.init(describing: error))
        }
    }

}
