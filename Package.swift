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
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.8.0/LeapSDK.xcframework.zip", checksum: "f8316464286834d73a0af6b89ba55ea656fef29a2366923f0ac4fc7852760bcd"
    ),
    .binaryTarget(
      name: "InferenceEngine",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.8.0/inference_engine.xcframework.zip", checksum: "50c712d71171e939940b44dcad7398ea64188f91ab15281c6a6d8e4d630cd445"
    ),
    .binaryTarget(
      name: "InferenceEngineExecutorchBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.8.0/inference_engine_executorch_backend.xcframework.zip", checksum: "71125ea6ea4b8cf73bed01234d7587143dcbdab39e351d4e081152455878d571"
    ),
    .binaryTarget(
      name: "InferenceEngineLlamaCppBackend",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.8.0/inference_engine_llamacpp_backend.xcframework.zip", checksum: "4c0158d6cf5a273c5b16693ce6fd1fadf34657bed463a1667c3a3528e7c7e6f3"
    ),
    .binaryTarget(
      name: "LeapModelDownloader",
      url: "https://github.com/Liquid4All/leap-ios/releases/download/v0.8.0/LeapModelDownloader.xcframework.zip", checksum: "978ac70c20d5cbe043c1abd64a169c1b69ce5c39cc230464a7db4251a07b7167"
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
