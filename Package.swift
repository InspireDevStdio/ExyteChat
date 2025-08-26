// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Chat",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "ExyteChat",
            targets: ["ExyteChat"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/InspireDevStdio/ExyteMediaPicker",
            exact: "1.0.0"
        ),
        .package(
            url: "https://github.com/InspireDevStdio/ExyteActivityIndicator",
            exact: "1.0.0"
        ),
        .package(
           url: "https://github.com/Giphy/giphy-ios-sdk",
           from: "2.2.13"
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher",
            from: "8.5.0"
        ),
    ],
    targets: [
        .target(
            name: "ExyteChat",
            dependencies: [
                .product(name: "ExyteMediaPicker", package: "ExyteMediaPicker"),
                .product(name: "ExyteActivityIndicator", package: "ExyteActivityIndicator"),
                .product(name: "GiphyUISDK", package: "giphy-ios-sdk"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            path: "Sources"
        ),
        .testTarget(
            name: "ExyteChatTests",
            dependencies: ["ExyteChat"]),
    ]
)
