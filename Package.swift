// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

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
    ),
    .library(
      name: "LeapSDKTypes",
      targets: ["LeapSDKTypes"]
    ),
    .library(
      name: "LeapSDKConstrainedGeneration",
      targets: ["LeapSDKConstrainedGeneration"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0")
  ],
  targets: [
    .binaryTarget(
      name: "LeapSDK",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.3.0-1/LeapSDK.xcframework.zip",
      checksum: "34a9d1e962889d9c5dd4caea0b7ef6ff07c560b329233ee418d728710abcdad6"
    ),
    .binaryTarget(
      name: "LeapSDKTypes",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.3.0-1/LeapSDKTypes.xcframework.zip",
      checksum: "c5209b6e4536e96f163ec025febc373a4a32a132fd1bf5089cc5aefc25d18b50"
    ),
    .target(
      name: "LeapSDKConstrainedGeneration",
      dependencies: [
        "LeapSDKConstrainedGenerationPlugin",
        "LeapSDKTypes"
      ],
      path: "Sources/LeapSDKConstrainedGeneration"
    ),
    .macro(
      name: "LeapSDKConstrainedGenerationPlugin",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
        "LeapSDKTypes"
      ],
      path: "Sources/LeapSDKConstrainedGenerationPlugin"
    )
  ]
)
