// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "MarkInsideWebsite",
    platforms: [.macOS(.v12)],
    products: [
        .executable(
            name: "MarkInsideWebsite",
            targets: ["MarkInsideWebsite"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.6.0")
    ],
    targets: [
        .executableTarget(
            name: "MarkInsideWebsite",
            dependencies: [.product(name: "Publish", package: "publish")]
        )
    ]
)
