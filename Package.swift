// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
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
      targets: ["LeapSDK", "LeapModelDownloader", "LeapSDKSupport", "LeapSDKMacros"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0")
  ],
  targets: [
    .binaryTarget(
      name: "LeapSDK",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.4/LeapSDK.xcframework.zip", checksum: "5d950b62e6ab21efa5cc74a8ffae9ea0d669edf6a5af58eec7e770566106716a"
    ),
    .binaryTarget(
      name: "InferenceEngine",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.4/inference_engine.xcframework.zip", checksum: "97d4e35dcf0e7a1687c22ab86fc405ac05dcfb4cb0b97faf2b74c03732ff82f3"
    ),
    .binaryTarget(
      name: "InferenceEngineExecutorchBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.4/inference_engine_executorch_backend.xcframework.zip", checksum: "045121b2d79ebd2f07ac263d5cbeb7b74cf27c091fcf336e29b98590637575fc"
    ),
    .binaryTarget(
      name: "InferenceEngineLlamaCppBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.4/inference_engine_llamacpp_backend.xcframework.zip", checksum: "5b3be6062b8e3e98322e70ad8c0e4f7c529cc9093ba0da0c7ad57817c6e8fcbc"
    ),
    .binaryTarget(
      name: "LeapModelDownloader",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.4/LeapModelDownloader.xcframework.zip", checksum: "bcd1e3f398fd6226f7b59c72e3c2414ac43801e6d0eb2907e6de20eb1a251f2f"
    ),
    .target(
      name: "LeapSDKSupport",
      dependencies: [
        "InferenceEngine",
        "InferenceEngineExecutorchBackend",
        "InferenceEngineLlamaCppBackend",
      ],
      path: "Sources/LeapSDKSupport"
    ),
    .target(
      name: "LeapSDKMacros",
      dependencies: [
        "LeapSDK",
        "LeapSDKConstrainedGenerationPlugin",
      ],
      path: "Sources/LeapSDKMacros"
    ),
    .macro(
      name: "LeapSDKConstrainedGenerationPlugin",
      dependencies: [
        .product(name: "SwiftSyntax", package: "swift-syntax"),
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ],
      path: "Sources/LeapSDKConstrainedGenerationPlugin"
    ),
  ]
)