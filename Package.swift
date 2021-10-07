// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DPUIKit",
    platforms: [
        .iOS(.v11),
    ],
    products: [
        .library(
            name: "DPUIKit_Views",
            targets: ["DPUIKit_Views"]
        ),
    ],
    targets: [
        .target(
            name: "DPUIKit",
            path: "DPUIKit/Sources"
        ),
        .target(
            name: "DPUIKit_Views",
            dependencies: [
                "DPUIKit"
            ],
            path: "DPUIKit_Views/Sources"
        )
    ]
)
