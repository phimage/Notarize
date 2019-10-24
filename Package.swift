// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Notarize",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(
            name: "notarize", targets: ["Notarize"]
        ),
        .library(
            name: "NotarizeFrontend", targets: ["NotarizeFrontend"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/phimage/NotarizationInfo", .revision("HEAD")),
        .package(url: "https://github.com/phimage/NotarizationAuditLog", .revision("HEAD")),
        .package(url: "https://github.com/phimage/NotarizeProcess", .revision("HEAD")),
        .package(url: "https://github.com/Carthage/Commandant.git", .upToNextMinor(from: "0.17.0")),
        .package(url: "https://github.com/jpsim/Yams.git", .upToNextMinor(from: "2.0.0")),
        .package(url: "https://github.com/kylef/PathKit.git", .upToNextMinor(from:"1.0.0"))
    ],
    targets: [
        .target(
            name: "Notarize",
            dependencies: ["NotarizeFrontend"],
            path: "Sources/Notarize"
        ),
        .target(
            name: "NotarizeFrontend",
            dependencies: ["NotarizationInfo", "NotarizationAuditLog", "NotarizeProcess", "PathKit", "Commandant", "Yams"],
            path: "Sources/NotarizeFrontend"
        )
    ]
)
