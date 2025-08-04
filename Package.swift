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
      targets: ["LeapSDK", "LeapSDKTypes"]
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
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.3.0/LeapSDK.xcframework.zip",
      checksum: "bbf5f09be0e5327a80e06783773fde0489b24d73fa489b6f53b0ca93a205d4d9"
    ),
    .target(
      name: "LeapSDKTypes",
      path: "Sources/LeapSDKTypes"
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
