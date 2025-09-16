// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "LandmarksIDiOS",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "LandmarksIDiOS",
            targets: ["LandmarksIDiOS", "BluedotPointSDK"]),
    ],
    dependencies: [
    ],
    targets: [
        .binaryTarget(
            name: "BluedotPointSDK",
            url: "https://github.com/Bluedot-Innovation/PointSDK-iOS/releases/download/15.6.12/BDPointSDK.xcframework.zip",
            checksum: "5bce2da82f3da1f34b65128644b22b911584821696c592260ef81eac6eeaaa20"
        ),
        .binaryTarget(
            name: "LandmarksIDiOS",
            url: "https://github.com/LANDMARKSID/ios-lod-sdk/releases/download/3.0.0/LandmarksIDiOS.xcframework.zip",
            checksum: "dbe3c0d35679b9ff23e22f216280842bbe3be61367d2a6f273eff1fa478e8df6"
        ),
    ]
)