// swift-tools-version: 6.0

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "MemorizeIt",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "MemorizeIt",
            targets: ["AppModule"],
            bundleIdentifier: "hnsarthh.personal.MemorizeIt",
            teamIdentifier: "SW8FY3LA3R",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .smiley),
            accentColor: .presetColor(.green),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            appCategory: .games
        )
    ],
    dependencies: [
        .package(url: "https://github.com/twostraws/Subsonic.git", "0.2.0"..<"1.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "Subsonic", package: "subsonic")
            ],
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ],
    swiftLanguageVersions: [.version("6")]
)