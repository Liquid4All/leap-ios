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
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.3.0/LeapSDK.xcframework.zip",
      checksum: "187ffa9683a68762de49d6ea3e918596183a4ccc9191aa5f337d0399563baecc"
    ),
    .binaryTarget(
      name: "LeapSDKTypes",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.3.0/LeapSDKTypes.xcframework.zip",
      checksum: "24a22ef2a04385f176519e7d19c5e85f037f918b3ae44ca03734dc7479d00167"
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
