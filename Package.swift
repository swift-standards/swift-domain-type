// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-domain-standard",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
    ],
    products: [
        .library(name: "Domain Standard", targets: ["Domain Standard"])
    ],
    dependencies: [
        .package(url: "https://github.com/swift-ietf/swift-rfc-1035.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-1123.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5321.git", branch: "main"),
        .package(url: "https://github.com/swift-ietf/swift-rfc-5890.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Domain Standard",
            dependencies: [
                .product(name: "RFC 1035", package: "swift-rfc-1035"),
                .product(name: "RFC 1123", package: "swift-rfc-1123"),
                .product(name: "RFC 5321", package: "swift-rfc-5321"),
                .product(name: "RFC 5890", package: "swift-rfc-5890"),
            ]
        ),
        .testTarget(
            name: "Domain Standard Tests",
            dependencies: [
                .target(name: "Domain Standard")
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
