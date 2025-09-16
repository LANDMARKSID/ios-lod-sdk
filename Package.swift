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
            checksum: "c2c928810976b48ac0f37a4b614557c2824982716cd948c60b59b229ea1d5028"
        ),
    ]
)