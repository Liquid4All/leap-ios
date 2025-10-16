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
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.0/LeapSDK.xcframework.zip", checksum: "0cdb5350c726e460613ebf86fe8ebf9bb742491ec45a4ba00f6b980b5e970495"
    ),
    .binaryTarget(
      name: "InferenceEngine",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.0/inference_engine.xcframework.zip", checksum: "39c901daed930ce1d359da2c26c1e9e2fd6984440a730d0b6676077a0f23cd0b"
    ),
    .binaryTarget(
      name: "InferenceEngineExecutorchBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.0/inference_engine_executorch_backend.xcframework.zip", checksum: "fc2e8715348223129a98d5186a243da8747cd93c4b249b298d6b73e96d08ed9f"
    ),
    .binaryTarget(
      name: "InferenceEngineLlamaCppBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.0/inference_engine_llamacpp_backend.xcframework.zip", checksum: "1800b40ec5d32dbea146c043065a50d7a95c301d9caa64bb4076a195611cdd77"
    ),
    .binaryTarget(
      name: "LeapModelDownloader",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.7.0/LeapModelDownloader.xcframework.zip", checksum: "10a6281465aa53ac7a6f8fd5d4d1fc80dbf9868c0a30142dd1294a229ebe630e"
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
