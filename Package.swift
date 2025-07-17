// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LeapSDK",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .macCatalyst(.v15),
  ],
  products: [
    .library(
      name: "LeapSDK",
      targets: ["LeapSDK"]
    )
  ],
  targets: [
    .binaryTarget(
      name: "LeapSDK",
      url:
        "https://github.com/Liquid4All/leap-ios/releases/download/v0.1.0/LeapSDK.xcframework.zip",
      checksum: "2ebc596c70d3d42651b8c6b200ed42a77fcb32eee5fbd4488b2efc4a633bab85"
    )
  ]
)
