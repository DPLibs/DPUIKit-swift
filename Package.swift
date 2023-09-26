// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DPUIKit",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "DPUIKit",
            targets: ["DPUIKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "5.15.6")
    ],
    targets: [
        .target(
            name: "DPUIKit",
            dependencies: [
                "Kingfisher"
            ],
            path: "Sources/DPUIKit",
            exclude: [
                "../../Demo",
                "../../Docs"
            ]
        )
    ]
)
