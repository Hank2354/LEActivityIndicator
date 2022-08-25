// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "LEActivityIndicator",
    platforms: [.iOS(.v13), .macCatalyst(.v13)],
    products: [
        .library(name: "LEActivityIndicator", targets: ["LEActivityIndicator"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "LEActivityIndicator", path: "Classes"),
    ]
)
