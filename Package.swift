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
      targets: ["LeapSDK", "LeapSDKSupport", "LeapSDKMacros"]
    ),
    .library(
      name: "LeapModelDownloader",
      targets: ["LeapModelDownloader"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0")
  ],
  targets: [
    .binaryTarget(
      name: "LeapSDK",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.0/LeapSDK.xcframework.zip", checksum: "37177b02f757d46f2f68e8d64b74dae15a6daca9fac4382722f64e1091fadf30"
    ),
    .binaryTarget(
      name: "InferenceEngine",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.0/inference_engine.xcframework.zip", checksum: "8cea2abca1652a39a49280cc924e5c613479794ee0995950550c9d11fdd58a6a"
    ),
    .binaryTarget(
      name: "InferenceEngineExecutorchBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.0/inference_engine_executorch_backend.xcframework.zip", checksum: "2a548cd627d8a3d7c292cd63b1d483e4f093e816e3f00b012d4e685cc8fb8ec8"
    ),
    .binaryTarget(
      name: "InferenceEngineLlamaCppBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.0/inference_engine_llamacpp_backend.xcframework.zip", checksum: "bdff87d36a89a782bafbd853ac36962b7dc9d19d03449e6ef8b4fb391c0af0a9"
    ),
    .binaryTarget(
      name: "LeapModelDownloader",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.9.0/LeapModelDownloader.xcframework.zip", checksum: "38ba37fb9a420711c0c43b7ba16055374192adf687a914918f0b6716943676d5"
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
