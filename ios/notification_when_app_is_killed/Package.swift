// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "notification_when_app_is_killed",
    platforms: [
        .iOS("12.0")
    ],
    products: [
        .library(name: "notification-when-app-is-killed", targets: ["notification_when_app_is_killed"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "notification_when_app_is_killed",
            dependencies: [],
            resources: []
        )
    ]
)
