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
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.5/LeapSDK.xcframework.zip", checksum: "48bef783b4179a418f234053d5c5a917837d8a2871a37ca7386a60c55d96f426"
    ),
    .binaryTarget(
      name: "InferenceEngine",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.5/inference_engine.xcframework.zip", checksum: "c74dca8010460a68bb4129bbcb0c47df1c86216c1076d6053662fde10f7fccae"
    ),
    .binaryTarget(
      name: "InferenceEngineExecutorchBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.5/inference_engine_executorch_backend.xcframework.zip", checksum: "305e740661b0608ee921e9c0435022c6dbb5198094b4204ed39545d26be4b5aa"
    ),
    .binaryTarget(
      name: "InferenceEngineLlamaCppBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.5/inference_engine_llamacpp_backend.xcframework.zip", checksum: "aaf31d479d7640b36d69df11701f98d50dffa9036d177c88f5e458c354435bdf"
    ),
    .binaryTarget(
      name: "LeapModelDownloader",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.5/LeapModelDownloader.xcframework.zip", checksum: "62ea600eee9ae75d666425898bb0d6b899f3256bfec26c92a91443743b22a963"
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
